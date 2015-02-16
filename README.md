# mainBowerOnefile [![NPM version][npm-image]][npm]
## Install
```bash
$ npm install main-bower-onefile -g
```

## onefile CLI
```bash
$ cd /path/to/bower-json-directory
$ bower install
$ onefile bower_components.js
# compiled bower_components.js
```

## help
```bash
$ onefile

  Usage: onefile name[.js] [options...]

  Options:

    -h, --help       output usage information
    -j, --json       Use [./bower.json]
    -d, --directory  Use [./bower_components]
    -r, --rc         Use [./.bowerrc]
    -u, --uglifyjs   Use UglifyJS2 (Experimental)
```

## Support extension
* js
* css
  * Convert to base64-datauri by `url()`

### Example
```json
{
  "name": "animate2js",
  "dependencies": {
    "animate.css": "~3.2.0"
  }
}
```

```bash
$ bower install
$ tree 
.
├── bower.json
└── bower_components
    └── animate.css
$ onefile bundle
# Compiled bundle.js

$ tree 
.
├── bundle.js
├── bower.json
└── bower_components
    └── animate.css
```

bundle.js
```js
(function(){
  var link=document.createElement('link');
  link.setAttribute('data-name','animate');
  link.setAttribute('rel','stylesheet');
  link.setAttribute('href',"data:text/css;charset=utf8;base64,QGNoYXJzZXQgIlVU..."
  document.head.appendChild(link);
})();
```

use bundle.js
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script src="bundle.js"></script>
</head>
<body>
  <h1 class="animated bounce">Hi</h1>
</body>
</html>
```

## Feture
* **TEST**

# License
MIT by [@59naga](https://twitter.com/horse_n_deer)

[npm-image]: https://badge.fury.io/js/main-bower-onefile.svg
[npm]: https://npmjs.org/package/main-bower-onefile
[travis-image]: https://travis-ci.org/59naga/main-bower-onefile.svg?branch=master
[travis]: https://travis-ci.org/59naga/main-bower-onefile
[depstat-image]: https://gemnasium.com/59naga/main-bower-onefile.svg
[depstat]: https://gemnasium.com/59naga/main-bower-onefile
