!function(){var e="object"==typeof self&&self.self===self&&self||"object"==typeof global&&global.global===global&&global,t=e._,n=Array.prototype,i=Object.prototype,a=n.push,o=n.slice,s=i.toString,r=i.hasOwnProperty,c=Array.isArray,l=Object.keys,d=Object.create,u=function(){},h=function(e){return e instanceof h?e:this instanceof h?void(this._wrapped=e):new h(e)};"undefined"!=typeof exports?("undefined"!=typeof module&&module.exports&&(exports=module.exports=h),exports._=h):e._=h,h.VERSION="1.8.3";var m=function(e,t,n){if(void 0===t)return e;switch(null==n?3:n){case 1:return function(n){return e.call(t,n)};case 2:return function(n,i){return e.call(t,n,i)};case 3:return function(n,i,a){return e.call(t,n,i,a)};case 4:return function(n,i,a,o){return e.call(t,n,i,a,o)}}return function(){return e.apply(t,arguments)}},p=function(e,t,n){return null==e?h.identity:h.isFunction(e)?m(e,t,n):h.isObject(e)?h.matcher(e):h.property(e)};h.iteratee=function(e,t){return p(e,t,1/0)};var f=function(e,t){return t=null==t?e.length-1:+t,function(){var n,i=Math.max(arguments.length-t,0),a=Array(i);for(n=0;i>n;n++)a[n]=arguments[n+t];switch(t){case 0:return e.call(this,a);case 1:return e.call(this,arguments[0],a);case 2:return e.call(this,arguments[0],arguments[1],a)}var o=Array(t+1);for(n=0;t>n;n++)o[n]=arguments[n];return o[t]=a,e.apply(this,o)}},g=function(e){if(!h.isObject(e))return{};if(d)return d(e);u.prototype=e;var t=new u;return u.prototype=null,t},v=function(e){return function(t){return null==t?void 0:t[e]}},b=Math.pow(2,53)-1,y=v("length"),_=function(e){var t=y(e);return"number"==typeof t&&t>=0&&b>=t};h.each=h.forEach=function(e,t,n){t=m(t,n);var i,a;if(_(e))for(i=0,a=e.length;a>i;i++)t(e[i],i,e);else{var o=h.keys(e);for(i=0,a=o.length;a>i;i++)t(e[o[i]],o[i],e)}return e},h.map=h.collect=function(e,t,n){t=p(t,n);for(var i=!_(e)&&h.keys(e),a=(i||e).length,o=Array(a),s=0;a>s;s++){var r=i?i[s]:s;o[s]=t(e[r],r,e)}return o};var w=function(e){var t=function(t,n,i,a){var o=!_(t)&&h.keys(t),s=(o||t).length,r=e>0?0:s-1;for(a||(i=t[o?o[r]:r],r+=e);r>=0&&s>r;r+=e){var c=o?o[r]:r;i=n(i,t[c],c,t)}return i};return function(e,n,i,a){var o=arguments.length>=3;return t(e,m(n,a,4),i,o)}};h.reduce=h.foldl=h.inject=w(1),h.reduceRight=h.foldr=w(-1),h.find=h.detect=function(e,t,n){var i;return i=_(e)?h.findIndex(e,t,n):h.findKey(e,t,n),void 0!==i&&-1!==i?e[i]:void 0},h.filter=h.select=function(e,t,n){var i=[];return t=p(t,n),h.each(e,function(e,n,a){t(e,n,a)&&i.push(e)}),i},h.reject=function(e,t,n){return h.filter(e,h.negate(p(t)),n)},h.every=h.all=function(e,t,n){t=p(t,n);for(var i=!_(e)&&h.keys(e),a=(i||e).length,o=0;a>o;o++){var s=i?i[o]:o;if(!t(e[s],s,e))return!1}return!0},h.some=h.any=function(e,t,n){t=p(t,n);for(var i=!_(e)&&h.keys(e),a=(i||e).length,o=0;a>o;o++){var s=i?i[o]:o;if(t(e[s],s,e))return!0}return!1},h.contains=h.includes=h.include=function(e,t,n,i){return _(e)||(e=h.values(e)),("number"!=typeof n||i)&&(n=0),h.indexOf(e,t,n)>=0},h.invoke=f(function(e,t,n){var i=h.isFunction(t);return h.map(e,function(e){var a=i?t:e[t];return null==a?a:a.apply(e,n)})}),h.pluck=function(e,t){return h.map(e,h.property(t))},h.where=function(e,t){return h.filter(e,h.matcher(t))},h.findWhere=function(e,t){return h.find(e,h.matcher(t))},h.max=function(e,t,n){var i,a,o=-1/0,s=-1/0;if(null==t&&null!=e){e=_(e)?e:h.values(e);for(var r=0,c=e.length;c>r;r++)i=e[r],i>o&&(o=i)}else t=p(t,n),h.each(e,function(e,n,i){a=t(e,n,i),(a>s||a===-1/0&&o===-1/0)&&(o=e,s=a)});return o},h.min=function(e,t,n){var i,a,o=1/0,s=1/0;if(null==t&&null!=e){e=_(e)?e:h.values(e);for(var r=0,c=e.length;c>r;r++)i=e[r],o>i&&(o=i)}else t=p(t,n),h.each(e,function(e,n,i){a=t(e,n,i),(s>a||1/0===a&&1/0===o)&&(o=e,s=a)});return o},h.shuffle=function(e){return h.sample(e,1/0)},h.sample=function(e,t,n){if(null==t||n)return _(e)||(e=h.values(e)),e[h.random(e.length-1)];var i=_(e)?h.clone(e):h.values(e),a=y(i);t=Math.max(Math.min(t,a),0);for(var o=a-1,s=0;t>s;s++){var r=h.random(s,o),c=i[s];i[s]=i[r],i[r]=c}return i.slice(0,t)},h.sortBy=function(e,t,n){return t=p(t,n),h.pluck(h.map(e,function(e,n,i){return{value:e,index:n,criteria:t(e,n,i)}}).sort(function(e,t){var n=e.criteria,i=t.criteria;if(n!==i){if(n>i||void 0===n)return 1;if(i>n||void 0===i)return-1}return e.index-t.index}),"value")};var C=function(e,t){return function(n,i,a){var o=t?[[],[]]:{};return i=p(i,a),h.each(n,function(t,a){var s=i(t,a,n);e(o,t,s)}),o}};h.groupBy=C(function(e,t,n){h.has(e,n)?e[n].push(t):e[n]=[t]}),h.indexBy=C(function(e,t,n){e[n]=t}),h.countBy=C(function(e,t,n){h.has(e,n)?e[n]++:e[n]=1}),h.toArray=function(e){return e?h.isArray(e)?o.call(e):_(e)?h.map(e,h.identity):h.values(e):[]},h.size=function(e){return null==e?0:_(e)?e.length:h.keys(e).length},h.partition=C(function(e,t,n){e[n?0:1].push(t)},!0),h.first=h.head=h.take=function(e,t,n){return null==e?void 0:null==t||n?e[0]:h.initial(e,e.length-t)},h.initial=function(e,t,n){return o.call(e,0,Math.max(0,e.length-(null==t||n?1:t)))},h.last=function(e,t,n){return null==e?void 0:null==t||n?e[e.length-1]:h.rest(e,Math.max(0,e.length-t))},h.rest=h.tail=h.drop=function(e,t,n){return o.call(e,null==t||n?1:t)},h.compact=function(e){return h.filter(e,h.identity)};var S=function(e,t,n,i){i=i||[];for(var a=i.length,o=0,s=y(e);s>o;o++){var r=e[o];if(_(r)&&(h.isArray(r)||h.isArguments(r)))if(t)for(var c=0,l=r.length;l>c;)i[a++]=r[c++];else S(r,t,n,i),a=i.length;else n||(i[a++]=r)}return i};h.flatten=function(e,t){return S(e,t,!1)},h.without=f(function(e,t){return h.difference(e,t)}),h.uniq=h.unique=function(e,t,n,i){h.isBoolean(t)||(i=n,n=t,t=!1),null!=n&&(n=p(n,i));for(var a=[],o=[],s=0,r=y(e);r>s;s++){var c=e[s],l=n?n(c,s,e):c;t?(s&&o===l||a.push(c),o=l):n?h.contains(o,l)||(o.push(l),a.push(c)):h.contains(a,c)||a.push(c)}return a},h.union=f(function(e){return h.uniq(S(e,!0,!0))}),h.intersection=function(e){for(var t=[],n=arguments.length,i=0,a=y(e);a>i;i++){var o=e[i];if(!h.contains(t,o)){var s;for(s=1;n>s&&h.contains(arguments[s],o);s++);s===n&&t.push(o)}}return t},h.difference=f(function(e,t){return t=S(t,!0,!0),h.filter(e,function(e){return!h.contains(t,e)})}),h.unzip=function(e){for(var t=e&&h.max(e,y).length||0,n=Array(t),i=0;t>i;i++)n[i]=h.pluck(e,i);return n},h.zip=f(h.unzip),h.object=function(e,t){for(var n={},i=0,a=y(e);a>i;i++)t?n[e[i]]=t[i]:n[e[i][0]]=e[i][1];return n};var A=function(e){return function(t,n,i){n=p(n,i);for(var a=y(t),o=e>0?0:a-1;o>=0&&a>o;o+=e)if(n(t[o],o,t))return o;return-1}};h.findIndex=A(1),h.findLastIndex=A(-1),h.sortedIndex=function(e,t,n,i){n=p(n,i,1);for(var a=n(t),o=0,s=y(e);s>o;){var r=Math.floor((o+s)/2);n(e[r])<a?o=r+1:s=r}return o};var k=function(e,t,n){return function(i,a,s){var r=0,c=y(i);if("number"==typeof s)e>0?r=s>=0?s:Math.max(s+c,r):c=s>=0?Math.min(s+1,c):s+c+1;else if(n&&s&&c)return s=n(i,a),i[s]===a?s:-1;if(a!==a)return s=t(o.call(i,r,c),h.isNaN),s>=0?s+r:-1;for(s=e>0?r:c-1;s>=0&&c>s;s+=e)if(i[s]===a)return s;return-1}};h.indexOf=k(1,h.findIndex,h.sortedIndex),h.lastIndexOf=k(-1,h.findLastIndex),h.range=function(e,t,n){null==t&&(t=e||0,e=0),n=n||1;for(var i=Math.max(Math.ceil((t-e)/n),0),a=Array(i),o=0;i>o;o++,e+=n)a[o]=e;return a};var x=function(e,t,n,i,a){if(!(i instanceof t))return e.apply(n,a);var o=g(e.prototype),s=e.apply(o,a);return h.isObject(s)?s:o};h.bind=f(function(e,t,n){if(!h.isFunction(e))throw new TypeError("Bind must be called on a function");var i=f(function(a){return x(e,i,t,this,n.concat(a))});return i}),h.partial=f(function(e,t){var n=h.partial.placeholder,i=function(){for(var a=0,o=t.length,s=Array(o),r=0;o>r;r++)s[r]=t[r]===n?arguments[a++]:t[r];for(;a<arguments.length;)s.push(arguments[a++]);return x(e,i,this,this,s)};return i}),h.partial.placeholder=h,h.bindAll=f(function(e,t){t=S(t,!1,!1);var n=t.length;if(1>n)throw new Error("bindAll must be passed function names");for(;n--;){var i=t[n];e[i]=h.bind(e[i],e)}}),h.memoize=function(e,t){var n=function(i){var a=n.cache,o=""+(t?t.apply(this,arguments):i);return h.has(a,o)||(a[o]=e.apply(this,arguments)),a[o]};return n.cache={},n},h.delay=f(function(e,t,n){return setTimeout(function(){return e.apply(null,n)},t)}),h.defer=h.partial(h.delay,h,1),h.throttle=function(e,t,n){var i,a,o,s=null,r=0;n||(n={});var c=function(){r=n.leading===!1?0:h.now(),s=null,o=e.apply(i,a),s||(i=a=null)};return function(){var l=h.now();r||n.leading!==!1||(r=l);var d=t-(l-r);return i=this,a=arguments,0>=d||d>t?(s&&(clearTimeout(s),s=null),r=l,o=e.apply(i,a),s||(i=a=null)):s||n.trailing===!1||(s=setTimeout(c,d)),o}},h.debounce=function(e,t,n){var i,a,o,s,r,c=function(){var l=h.now()-s;t>l&&l>=0?i=setTimeout(c,t-l):(i=null,n||(r=e.apply(o,a),i||(o=a=null)))};return function(){o=this,a=arguments,s=h.now();var l=n&&!i;return i||(i=setTimeout(c,t)),l&&(r=e.apply(o,a),o=a=null),r}},h.wrap=function(e,t){return h.partial(t,e)},h.negate=function(e){return function(){return!e.apply(this,arguments)}},h.compose=function(){var e=arguments,t=e.length-1;return function(){for(var n=t,i=e[t].apply(this,arguments);n--;)i=e[n].call(this,i);return i}},h.after=function(e,t){return function(){return--e<1?t.apply(this,arguments):void 0}},h.before=function(e,t){var n;return function(){return--e>0&&(n=t.apply(this,arguments)),1>=e&&(t=null),n}},h.once=h.partial(h.before,2),h.restArgs=f;var T=!{toString:null}.propertyIsEnumerable("toString"),D=["valueOf","isPrototypeOf","toString","propertyIsEnumerable","hasOwnProperty","toLocaleString"],M=function(e,t){var n=D.length,a=e.constructor,o=h.isFunction(a)&&a.prototype||i,s="constructor";for(h.has(e,s)&&!h.contains(t,s)&&t.push(s);n--;)s=D[n],s in e&&e[s]!==o[s]&&!h.contains(t,s)&&t.push(s)};h.keys=function(e){if(!h.isObject(e))return[];if(l)return l(e);var t=[];for(var n in e)h.has(e,n)&&t.push(n);return T&&M(e,t),t},h.allKeys=function(e){if(!h.isObject(e))return[];var t=[];for(var n in e)t.push(n);return T&&M(e,t),t},h.values=function(e){for(var t=h.keys(e),n=t.length,i=Array(n),a=0;n>a;a++)i[a]=e[t[a]];return i},h.mapObject=function(e,t,n){t=p(t,n);for(var i=h.keys(e),a=i.length,o={},s=0;a>s;s++){var r=i[s];o[r]=t(e[r],r,e)}return o},h.pairs=function(e){for(var t=h.keys(e),n=t.length,i=Array(n),a=0;n>a;a++)i[a]=[t[a],e[t[a]]];return i},h.invert=function(e){for(var t={},n=h.keys(e),i=0,a=n.length;a>i;i++)t[e[n[i]]]=n[i];return t},h.functions=h.methods=function(e){var t=[];for(var n in e)h.isFunction(e[n])&&t.push(n);return t.sort()};var N=function(e,t){return function(n){var i=arguments.length;if(2>i||null==n)return n;for(var a=1;i>a;a++)for(var o=arguments[a],s=e(o),r=s.length,c=0;r>c;c++){var l=s[c];t&&void 0!==n[l]||(n[l]=o[l])}return n}};h.extend=N(h.allKeys),h.extendOwn=h.assign=N(h.keys),h.findKey=function(e,t,n){t=p(t,n);for(var i,a=h.keys(e),o=0,s=a.length;s>o;o++)if(i=a[o],t(e[i],i,e))return i};var E=function(e,t,n){return t in n};h.pick=f(function(e,t){var n={},i=t[0];if(null==e)return n;h.isFunction(i)?(t.length>1&&(i=m(i,t[1])),t=h.allKeys(e)):(i=E,t=S(t,!1,!1),e=Object(e));for(var a=0,o=t.length;o>a;a++){var s=t[a],r=e[s];i(r,s,e)&&(n[s]=r)}return n}),h.omit=f(function(e,t){var n,i=t[0];return h.isFunction(i)?(i=h.negate(i),t.length>1&&(n=t[1])):(t=h.map(S(t,!1,!1),String),i=function(e,n){return!h.contains(t,n)}),h.pick(e,i,n)}),h.defaults=N(h.allKeys,!0),h.create=function(e,t){var n=g(e);return t&&h.extendOwn(n,t),n},h.clone=function(e){return h.isObject(e)?h.isArray(e)?e.slice():h.extend({},e):e},h.tap=function(e,t){return t(e),e},h.isMatch=function(e,t){var n=h.keys(t),i=n.length;if(null==e)return!i;for(var a=Object(e),o=0;i>o;o++){var s=n[o];if(t[s]!==a[s]||!(s in a))return!1}return!0};var I,P;I=function(e,t,n,i){if(e===t)return 0!==e||1/e===1/t;if(null==e||null==t)return e===t;if(e!==e)return t!==t;var a=typeof e;return"function"!==a&&"object"!==a&&"object"!=typeof t?!1:P(e,t,n,i)},P=function(e,t,n,i){e instanceof h&&(e=e._wrapped),t instanceof h&&(t=t._wrapped);var a=s.call(e);if(a!==s.call(t))return!1;switch(a){case"[object RegExp]":case"[object String]":return""+e==""+t;case"[object Number]":return+e!==+e?+t!==+t:0===+e?1/+e===1/t:+e===+t;case"[object Date]":case"[object Boolean]":return+e===+t}var o="[object Array]"===a;if(!o){if("object"!=typeof e||"object"!=typeof t)return!1;var r=e.constructor,c=t.constructor;if(r!==c&&!(h.isFunction(r)&&r instanceof r&&h.isFunction(c)&&c instanceof c)&&"constructor"in e&&"constructor"in t)return!1}n=n||[],i=i||[];for(var l=n.length;l--;)if(n[l]===e)return i[l]===t;if(n.push(e),i.push(t),o){if(l=e.length,l!==t.length)return!1;for(;l--;)if(!I(e[l],t[l],n,i))return!1}else{var d,u=h.keys(e);if(l=u.length,h.keys(t).length!==l)return!1;for(;l--;)if(d=u[l],!h.has(t,d)||!I(e[d],t[d],n,i))return!1}return n.pop(),i.pop(),!0},h.isEqual=function(e,t){return I(e,t)},h.isEmpty=function(e){return null==e?!0:_(e)&&(h.isArray(e)||h.isString(e)||h.isArguments(e))?0===e.length:0===h.keys(e).length},h.isElement=function(e){return!(!e||1!==e.nodeType)},h.isArray=c||function(e){return"[object Array]"===s.call(e)},h.isObject=function(e){var t=typeof e;return"function"===t||"object"===t&&!!e},h.each(["Arguments","Function","String","Number","Date","RegExp","Error"],function(e){h["is"+e]=function(t){return s.call(t)==="[object "+e+"]"}}),h.isArguments(arguments)||(h.isArguments=function(e){return h.has(e,"callee")}),"function"!=typeof/./&&"object"!=typeof Int8Array&&(h.isFunction=function(e){return"function"==typeof e||!1}),h.isFinite=function(e){return isFinite(e)&&!isNaN(parseFloat(e))},h.isNaN=function(e){return h.isNumber(e)&&e!==+e},h.isBoolean=function(e){return e===!0||e===!1||"[object Boolean]"===s.call(e)},h.isNull=function(e){return null===e},h.isUndefined=function(e){return void 0===e},h.has=function(e,t){return null!=e&&r.call(e,t)},h.noConflict=function(){return e._=t,this},h.identity=function(e){return e},h.constant=function(e){return function(){return e}},h.noop=function(){},h.property=v,h.propertyOf=function(e){return null==e?function(){}:function(t){return e[t]}},h.matcher=h.matches=function(e){return e=h.extendOwn({},e),function(t){return h.isMatch(t,e)}},h.times=function(e,t,n){var i=Array(Math.max(0,e));t=m(t,n,1);for(var a=0;e>a;a++)i[a]=t(a);return i},h.random=function(e,t){return null==t&&(t=e,e=0),e+Math.floor(Math.random()*(t-e+1))},h.now=Date.now||function(){return(new Date).getTime()};var O={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","`":"&#x60;"},L=h.invert(O),B=function(e){var t=function(t){return e[t]},n="(?:"+h.keys(e).join("|")+")",i=RegExp(n),a=RegExp(n,"g");return function(e){return e=null==e?"":""+e,i.test(e)?e.replace(a,t):e}};h.escape=B(O),h.unescape=B(L),h.result=function(e,t,n){var i=null==e?void 0:e[t];return void 0===i&&(i=n),h.isFunction(i)?i.call(e):i};var H=0;h.uniqueId=function(e){var t=++H+"";return e?e+t:t},h.templateSettings={evaluate:/<%([\s\S]+?)%>/g,interpolate:/<%=([\s\S]+?)%>/g,escape:/<%-([\s\S]+?)%>/g};var R=/(.)^/,z={"'":"'","\\":"\\","\r":"r","\n":"n","\u2028":"u2028","\u2029":"u2029"},K=/\\|'|\r|\n|\u2028|\u2029/g,j=function(e){return"\\"+z[e]};h.template=function(e,t,n){!t&&n&&(t=n),t=h.defaults({},t,h.templateSettings);var i=RegExp([(t.escape||R).source,(t.interpolate||R).source,(t.evaluate||R).source].join("|")+"|$","g"),a=0,o="__p+='";e.replace(i,function(t,n,i,s,r){return o+=e.slice(a,r).replace(K,j),a=r+t.length,n?o+="'+\n((__t=("+n+"))==null?'':_.escape(__t))+\n'":i?o+="'+\n((__t=("+i+"))==null?'':__t)+\n'":s&&(o+="';\n"+s+"\n__p+='"),t}),o+="';\n",t.variable||(o="with(obj||{}){\n"+o+"}\n"),o="var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};\n"+o+"return __p;\n";var s;try{s=new Function(t.variable||"obj","_",o)}catch(r){throw r.source=o,r}var c=function(e){return s.call(this,e,h)},l=t.variable||"obj";return c.source="function("+l+"){\n"+o+"}",c},h.chain=function(e){var t=h(e);return t._chain=!0,t};var F=function(e,t){return e._chain?h(t).chain():t};h.mixin=function(e){h.each(h.functions(e),function(t){var n=h[t]=e[t];h.prototype[t]=function(){var e=[this._wrapped];return a.apply(e,arguments),F(this,n.apply(h,e))}})},h.mixin(h),h.each(["pop","push","reverse","shift","sort","splice","unshift"],function(e){var t=n[e];h.prototype[e]=function(){var n=this._wrapped;return t.apply(n,arguments),"shift"!==e&&"splice"!==e||0!==n.length||delete n[0],F(this,n)}}),h.each(["concat","join","slice"],function(e){var t=n[e];h.prototype[e]=function(){return F(this,t.apply(this._wrapped,arguments))}}),h.prototype.value=function(){return this._wrapped},h.prototype.valueOf=h.prototype.toJSON=h.prototype.value,h.prototype.toString=function(){return""+this._wrapped},"function"==typeof define&&define.amd&&define("underscore",[],function(){return h})}(),function(e,t){var n={BACKSPACE:8,TAB:9,RETURN:13,ESC:27,LEFT:37,UP:38,RIGHT:39,DOWN:40,COMMA:188,SPACE:32,HOME:36,END:35},i={triggerChar:"@",onDataRequest:e.noop,minChars:2,allowRepeat:!1,showAvatars:!0,elastic:!0,defaultValue:"",onCaret:!1,classes:{autoCompleteItemActive:"active"},templates:{wrapper:t.template('<div class="mentions-input-box"></div>'),autocompleteList:t.template('<div class="mentions-autocomplete-list"></div>'),autocompleteListItem:t.template('<li data-ref-id="<%= id %>" data-ref-type="<%= type %>" data-display="<%= display %>"><%= content %></li>'),autocompleteListItemAvatar:t.template('<img src="<%= avatar %>" />'),autocompleteListItemIcon:t.template('<div class="icon <%= icon %>"></div>'),mentionsOverlay:t.template('<div class="mentions"><div></div></div>'),mentionItemSyntax:t.template("@[<%= value %>](<%= type %>:<%= id %>)"),mentionItemHighlight:t.template("<strong><span><%= value %></span></strong>")}},a={htmlEncode:function(e){return t.escape(e)},regexpEncode:function(e){return e.replace(/([.*+?^=!:${}()|\[\]\/\\])/g,"\\$1")},highlightTerm:function(e,t){return t||t.length?e.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)("+t+")(?![^<>]*>)(?![^&;]+;)","gi"),"<b>$1</b>"):e},setCaratPosition:function(e,t){if(e.createTextRange){var n=e.createTextRange();n.move("character",t),n.select()}else e.selectionStart?(e.focus(),e.setSelectionRange(t,t)):e.focus()},rtrim:function(e){return e.replace(/\s+$/,"")}},o=function(o){function s(){M=e(D),"true"!==M.attr("data-mentions-input")&&(N=M.parent(),I=e(o.templates.wrapper()),M.wrapAll(I),I=N.find("> div.mentions-input-box"),M.attr("data-mentions-input","true"),M.bind("keydown",w),M.bind("keypress",_),M.bind("click",v),M.bind("blur",b),navigator.userAgent.indexOf("MSIE 8")>-1?M.bind("propertychange",y):M.bind("input",y),o.elastic&&M.elastic())}function r(){E=e(o.templates.autocompleteList()),E.appendTo(I),E.delegate("li","mousedown",g)}function c(){P=e(o.templates.mentionsOverlay()),P.prependTo(I)}function l(){var e=m();t.each(L,function(t){var n=o.templates.mentionItemSyntax(t);e=e.replace(new RegExp(a.regexpEncode(t.value),"g"),n)});var n=a.htmlEncode(e);t.each(L,function(e){var i=t.extend({},e,{value:a.htmlEncode(e.value)}),s=o.templates.mentionItemSyntax(i),r=o.templates.mentionItemHighlight(i);n=n.replace(new RegExp(a.regexpEncode(s),"g"),r)}),n=n.replace(/\n/g,"<br />"),n=n.replace(/ {2}/g,"&nbsp; "),M.data("messageText",e),M.trigger("updated"),P.find("div").html(n)}function d(){H=[]}function u(){var e=m();L=t.reject(L,function(t){return!t.value||-1==e.indexOf(t.value)}),L=t.compact(L)}function h(e){var n=m(),i=new RegExp("\\"+o.triggerChar+R,"gi");i.exec(n);var s=i.lastIndex-R.length-1,r=i.lastIndex,c=n.substr(0,s),u=n.substr(r,n.length),h=(c+e.value).length+1;t.find(L,function(t){return t.id==e.id})||L.push(e),d(),R="",C();var p=c+e.value+" "+u;M.val(p),M.trigger("mention"),l(),M.focus(),a.setCaratPosition(M[0],h)}function m(){return e.trim(M.val())}function p(t){var n,i,a,o,s,r,c,l,d,u,h;if((d=t[0])&&e(d).is("textarea")&&null!=d.selectionEnd){for(c={position:"absolute",overflow:"auto",whiteSpace:"pre-wrap",wordWrap:"break-word",boxSizing:"content-box",top:0,left:-9999},l=["boxSizing","fontFamily","fontSize","fontStyle","fontVariant","fontWeight","height","letterSpacing","lineHeight","paddingBottom","paddingLeft","paddingRight","paddingTop","textDecoration","textIndent","textTransform","width","word-spacing"],u=0,h=l.length;h>u;u++)s=l[u],c[s]=e(d).css(s);return a=document.createElement("div"),e(a).css(c),e(d).after(a),i=document.createTextNode(d.value.substring(0,d.selectionEnd)),n=document.createTextNode(d.value.substring(d.selectionEnd)),o=document.createElement("span"),o.innerHTML="&nbsp;",a.appendChild(i),a.appendChild(o),a.appendChild(n),a.scrollTop=d.scrollTop,r=e(o).position(),e(a).remove(),r}}function f(){var t=e(M).offset().top,n=e("body").offset().top,i=e(window).scrollTop();i>t&&e(window).scrollTop(t-n)}function g(){var t=e(this),n=B[t.attr("data-uid")];return h(n),f(),!1}function v(){d()}function b(){C()}function y(){l(),u();var e=t.lastIndexOf(H,o.triggerChar);e>-1&&(R=H.slice(e+1).join(""),R=a.rtrim(R),t.defer(t.bind(k,this,R)))}function _(e){if(e.keyCode!==n.BACKSPACE){var t=String.fromCharCode(e.which||e.keyCode);H.push(t)}}function w(i){if(i.keyCode===n.LEFT||i.keyCode===n.RIGHT||i.keyCode===n.HOME||i.keyCode===n.END)return t.defer(d),void(navigator.userAgent.indexOf("MSIE 9")>-1&&t.defer(l));if(i.keyCode===n.BACKSPACE)return void(H=H.slice(0,-1+H.length));if(!E.is(":visible"))return!0;switch(i.keyCode){case n.UP:case n.DOWN:var a=null;return a=i.keyCode===n.DOWN?O&&O.length?O.next():E.find("li").first():e(O).prev(),a.length&&S(a),!1;case n.RETURN:case n.TAB:if(O&&O.length)return O.trigger("mousedown"),!1}return!0}function C(){O=null,E.empty().hide()}function S(e){e.addClass(o.classes.autoCompleteItemActive),e.siblings().removeClass(o.classes.autoCompleteItemActive),O=e}function A(n,i){if(E.show(),!o.allowRepeat){var s=t.pluck(L,"value");i=t.reject(i,function(e){return t.include(s,e.name)})}if(!i.length)return void C();E.empty();var r=e("<ul>").appendTo(E).hide();t.each(i,function(i,s){var c=t.uniqueId("mention_");B[c]=t.extend({},i,{value:i.name});var l=e(o.templates.autocompleteListItem({id:a.htmlEncode(i.id),display:a.htmlEncode(i.name),type:a.htmlEncode(i.type),content:a.highlightTerm(a.htmlEncode(i.display?i.display:i.name),n)})).attr("data-uid",c);if(0===s&&S(l),o.showAvatars){var d;d=e(i.avatar?o.templates.autocompleteListItemAvatar({avatar:i.avatar}):o.templates.autocompleteListItemIcon({icon:i.icon})),d.prependTo(l)}l=l.appendTo(r)}),E.show(),o.onCaret&&x(E,M),r.show()}function k(e){e&&e.length&&e.length>=o.minChars?o.onDataRequest.call(this,"search",e,function(t){A(e,t)}):C()}function x(e,t){var n=p(t),i=parseInt(t.css("line-height"),10)||18;e.css("width","15em"),e.css("left",n.left),e.css("top",i+n.top);var a=t.offset().left+t.width(),o=e.offset().left+e.width();o>=a&&e.css("left",Math.abs(e.position().left-(o-a)))}function T(e){L=[];for(var t,n=a.htmlEncode(e),i=new RegExp("("+o.triggerChar+")\\[(.*?)\\]\\((.*?):(.*?)\\)","gi"),s=n;null!=(t=i.exec(n));)s=s.replace(t[0],t[1]+t[2]),L.push({id:t[4],type:t[3],value:t[2],trigger:t[1]});M.val(s),l()}var D,M,N,E,I,P,O,L=[],B={},H=[],R="";return o=e.extend(!0,{},i,o),{init:function(e){D=e,s(),r(),c(),T(o.defaultValue),o.prefillMention&&h(o.prefillMention)},val:function(e){t.isFunction(e)&&e.call(this,L.length?M.data("messageText"):m())},reset:function(){T()},getMentions:function(e){t.isFunction(e)&&e.call(this,L)}}};e.fn.mentionsInput=function(n,i){var a=arguments;return"object"!=typeof n&&n||(i=n),this.each(function(){var s=e.data(this,"mentionsInput")||e.data(this,"mentionsInput",new o(i));return t.isFunction(s[n])?s[n].apply(this,Array.prototype.slice.call(a,1)):"object"!=typeof n&&n?void e.error("Method "+n+" does not exist"):s.init.call(this,this)})}}(jQuery,_),window.Commontator={},Commontator._=window._.noConflict(),Commontator.initMentions=function(){$(".comment_form_field textarea:not(.mentions-added)").each(function(e,t){$textarea=$(t),$form=$textarea.parents("form"),threadId=$textarea.parents(".thread").attr("id").match(/[\d]+/)[0],$textarea.addClass("mentions-added"),currentValue=$textarea.val(),$textarea.mentionsInput({elastic:!1,showAvatars:!1,allowRepeat:!0,minChars:3,onDataRequest:function(e,t,n){$.getJSON("/commontator/threads/"+threadId+"/mentions.json",{q:t},function(e){n.call(this,e.mentions)})}}),$textarea.val(currentValue),$textarea.on("focusout",function(){$textarea.mentionsInput("getMentions",function(e){$form.find('input[name="mentioned_ids[]"]').remove(),$(e).each(function(e,t){$input=$("<input>",{type:"hidden",name:"mentioned_ids[]",value:t.id}),$form.append($input)})})})})};