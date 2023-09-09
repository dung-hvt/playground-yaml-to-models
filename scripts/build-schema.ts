import * as fs from 'fs';
import * as yaml from 'js-yaml';
import * as glob from 'fast-glob';
import * as dot from 'dot';
import { JSONSchema4 } from 'json-schema';

const bundleRoot = 'bundles';
const jsonRoot = `${bundleRoot}/json`;
const prefix = '#/definitions';

const prefixProps = (given: JSONSchema4): JSONSchema4 => {
    const out = { ...given };

    if (!out.properties) {
        return out;
    }

    Object.keys(out.properties).forEach((key) => {
        const properties = out.properties![key];

        if (properties.$ref && !properties.$ref.startsWith(prefix)) {
            properties.$ref = `${prefix}${properties.$ref}`;
            return;
        }

        if (
            properties.items &&
            !Array.isArray(properties.items) &&
            properties.items.$ref &&
            !properties.items.$ref.startsWith(prefix)
        ) {
            properties.items.$ref = `${prefix}${properties.items.$ref}`;
        }
    });

    return out;
};

// ------------------------------------------------
// Step 1. Setup directories
// ------------------------------------------------

[bundleRoot, jsonRoot].forEach((dir) => {
    if (fs.existsSync(dir)) {
        return;
    }

    fs.mkdirSync(dir);
    console.log('directory created', dir);
});

// ------------------------------------------------
// Step 2. Generate partial schemas
// ------------------------------------------------

interface Chunk {
    id: string;
    doc: JSONSchema4;
}

const chunks: Chunk[] = [];

(() => {
    console.log('building partial schemas..');

    const render = dot.template(`{
        "$schema" : "http://json-schema.org/draft-04/schema#",
        "type": ["object"],
        "properties": {
            "{{=it.id}}": {
                "$ref": "#/definitions/{{=it.id}}"
            }
        },
        "definitions": {
            "{{=it.id}}": {{=it.doc}}
        }
    }`);

    // Collect all entries.
    glob.sync(['src/**/*.yml'], {
        stats: false,
    }).map((entry: string) => {
        let doc = yaml.load(fs.readFileSync(entry, 'utf8')) as JSONSchema4;

        const id = entry
            .replace(/\//g, '-')
            .replace('src-', '')
            .replace('.yml', '');

        // Polyfill properties.
        doc.title = id.split('-').join(' ');

        doc = prefixProps(doc);

        // Bind with template.
        const got = render({ id, doc: JSON.stringify(doc) });

        fs.writeFileSync(`bundles/json/${id}.json`, got);

        chunks.push({ id, doc });
    });
})();

// ------------------------------------------------
// Step 3. Generate unified schema
// ------------------------------------------------

(() => {
    console.log('building unified schema..');

    const render = dot.template(`{
        "$schema" : "http://json-schema.org/draft-04/schema#",
        "id": "schema",
        "title": "Schema",
        "description": "Schema definitions",
        "type": ["object"],
        "properties": {{=it.props}},
        "definitions": {{=it.definitions}}
    }`);

    const schema: JSONSchema4 = {
        properties: {},
        definitions: {},
    };

    chunks.forEach((chunk) => {
        schema.properties![chunk.id] = {
            $ref: `${prefix}/${chunk.id}`,
        };

        schema.definitions![chunk.id] = prefixProps(chunk.doc);
    });

    // Bind with template.
    const got = render({
        props: JSON.stringify(schema.properties),
        definitions: JSON.stringify(schema.definitions),
    });

    fs.writeFileSync(`bundles/json/schema.json`, got);

    console.log('done!');
})();
