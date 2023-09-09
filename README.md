# playground-yaml-to-models
Tool generator from multiple yaml files to DTO (Restful API Request/Response)

`src/*.yaml` --> `build/schema.json` --> `Typescript, Golang, Dart` models.

## Supported Inputs
```
1. JSON Schema (draft-04)
```

## Supported Outputs
```
1. Typescript
2. Golang
3. Dart
```
TODO: supports other Outputs


## How to work?

### Install
```
make install
```

### Build
```
make build
```

### Examples
1. Yaml files structures: 
```
src/
├── common
│   ├── error-response.yml
├── v1
    ├── enum
    |   ├── order-status.yml
    ├── object
    |   ├── order.yml
    |   ├── user.yml
    ├── orders
    |   ├── (create | update | delete)-request.yml
    |   ├── (create | index | show | update | delete)-response.yml
    ├── users
    |   ├── (create | update | delete)-request.yml
    |   ├── (create | index | show | update | delete)-response.yml
```

2. Models has been generated:
    - [Typescript](https://github.com/dung-hvt/playground-yaml-to-models/blob/develop/examples/bundles/typescript)
    - [Golang](https://github.com/dung-hvt/playground-yaml-to-models/blob/develop/examples/bundles/golang)
    - [Dart](https://github.com/dung-hvt/playground-yaml-to-models/blob/develop/examples/bundles/dart)

#### Reference Libraries
- https://github.com/quicktype/quicktype
- https://github.com/nodeca/js-yaml
- https://github.com/kriszyp/json-schema
