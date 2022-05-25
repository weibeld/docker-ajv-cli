# ajv-cli

An Alpine based Docker image containing [ajv-cli](https://www.npmjs.com/package/ajv-cli).

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/weibeld/ajv-cli?color=blue&label=docker%20hub&logo=docker&logoColor=white&sort=semver)](https://hub.docker.com/r/weibeld/ajv-cli)
[![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/weibeld/ajv-cli?color=blue&label=image%20size&logo=docker&logoColor=white&sort=semver)](https://hub.docker.com/r/weibeld/ajv-cli)

## Tags

The image tag corresponds to the installed ajv-cli version:

| Image tag | ajv-cli version |
|----------:|----------------:|
| [5.0.0](https://hub.docker.com/r/weibeld/ajv-cli/tags?page=1&name=5.0.0) | [5.0.0](https://www.npmjs.com/package/ajv-cli/v/5.0.0) |

## Extensions

The Docker image includes the following [Ajv extensions](https://ajv.js.org/packages/):

- [ajv-formats](https://ajv.js.org/packages/ajv-formats.html): predefined formats that can be used with the ["format"](https://json-schema.org/draft/2020-12/json-schema-validation.html#format) keyword in schemas.

## Examples

Assume the following JSON schema in `schema.json`:

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Websites",
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "name": {
        "type": "string"
      },
      "url": {
        "type": "string",
        "format": "uri"
      }
    },
    "required": [ "name", "url" ]
  }
}
```

And the following YAML file in `data.yaml`:

```yaml
- name: GitHub
  url: https://github.com
- name: Wikipedia
  url: https://en.wikipedia.org/
- name: Kubernetes
  url: https://kubernetes.io/
```

To validate this YAML file against the schema, use the following command:

```bash
ajv \
  --spec draft2020 \
  -c ajv-formats \
  -s schema.json \
  -d data.yaml
```

Note the following about this command:

- The [`--spec`](https://ajv.js.org/packages/ajv-cli.html#json-schema-language-and-version) option indicates the version of the specification that the schema adheres too, which is necessary because ajv-cli uses an older version of the specification by default.
- The [`-c`](https://ajv.js.org/packages/ajv-cli.html#c-custom-keywords-formats-definitions) option imports the [ajv-formats](https://ajv.js.org/packages/ajv-formats.html) extension, which is necessary because the schema uses the ["format"](https://json-schema.org/draft/2020-12/json-schema-validation.html#rfc.section.7.3.5) keyword.
- The [`-s`](https://ajv.js.org/packages/ajv-cli.html#s-file-name-of-json-schema) and [`-d`](https://ajv.js.org/packages/ajv-cli.html#d-json-data) options specify the JSON schema file and the data file to validate, respectively.
