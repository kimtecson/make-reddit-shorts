var e="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var t={};
/*! @license ScrollReveal v4.0.9

	Copyright 2021 Fisssion LLC.

	Licensed under the GNU General Public License 3.0 for
	compatible open source projects and non-commercial use.

	For commercial sites, themes, projects, and applications,
	keep your source code private/proprietary by purchasing
	a commercial license from https://scrollrevealjs.org/
*/(function(e,r){t=r()})(0,(function(){var t={delay:0,distance:"0",duration:600,easing:"cubic-bezier(0.5, 0, 0, 1)",interval:0,opacity:0,origin:"bottom",rotate:{x:0,y:0,z:0},scale:1,cleanup:false,container:document.documentElement,desktop:true,mobile:true,reset:false,useDelay:"always",viewFactor:0,viewOffset:{top:0,right:0,bottom:0,left:0},afterReset:function afterReset(){},afterReveal:function afterReveal(){},beforeReset:function beforeReset(){},beforeReveal:function beforeReveal(){}};function failure(){document.documentElement.classList.remove("sr");return{clean:function clean(){},destroy:function destroy(){},reveal:function reveal(){},sync:function sync(){},get noop(){return true}}}function success(){document.documentElement.classList.add("sr");document.body?document.body.style.height="100%":document.addEventListener("DOMContentLoaded",(function(){document.body.style.height="100%"}))}var r={success:success,failure:failure};
/*! @license is-dom-node v1.0.4
  		Copyright 2018 Fisssion LLC.
  		Permission is hereby granted, free of charge, to any person obtaining a copy
  	of this software and associated documentation files (the "Software"), to deal
  	in the Software without restriction, including without limitation the rights
  	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  	copies of the Software, and to permit persons to whom the Software is
  	furnished to do so, subject to the following conditions:
  		The above copyright notice and this permission notice shall be included in all
  	copies or substantial portions of the Software.
  		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  	SOFTWARE.
  	*/function isDomNode(e){return"object"===typeof window.Node?e instanceof window.Node:null!==e&&"object"===typeof e&&"number"===typeof e.nodeType&&"string"===typeof e.nodeName}
/*! @license is-dom-node-list v1.2.1
  		Copyright 2018 Fisssion LLC.
  		Permission is hereby granted, free of charge, to any person obtaining a copy
  	of this software and associated documentation files (the "Software"), to deal
  	in the Software without restriction, including without limitation the rights
  	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  	copies of the Software, and to permit persons to whom the Software is
  	furnished to do so, subject to the following conditions:
  		The above copyright notice and this permission notice shall be included in all
  	copies or substantial portions of the Software.
  		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  	SOFTWARE.
  	*/function isDomNodeList(e){var t=Object.prototype.toString.call(e);var r=/^\[object (HTMLCollection|NodeList|Object)\]$/;return"object"===typeof window.NodeList?e instanceof window.NodeList:null!==e&&"object"===typeof e&&"number"===typeof e.length&&r.test(t)&&(0===e.length||isDomNode(e[0]))}
/*! @license Tealight v0.3.6
  		Copyright 2018 Fisssion LLC.
  		Permission is hereby granted, free of charge, to any person obtaining a copy
  	of this software and associated documentation files (the "Software"), to deal
  	in the Software without restriction, including without limitation the rights
  	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  	copies of the Software, and to permit persons to whom the Software is
  	furnished to do so, subject to the following conditions:
  		The above copyright notice and this permission notice shall be included in all
  	copies or substantial portions of the Software.
  		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  	SOFTWARE.
  	*/function tealight(e,t){void 0===t&&(t=document);if(e instanceof Array)return e.filter(isDomNode);if(isDomNode(e))return[e];if(isDomNodeList(e))return Array.prototype.slice.call(e);if("string"===typeof e)try{var r=t.querySelectorAll(e);return Array.prototype.slice.call(r)}catch(e){return[]}return[]}function isObject(e){return null!==e&&e instanceof Object&&(e.constructor===Object||"[object Object]"===Object.prototype.toString.call(e))}function each(e,t){if(isObject(e)){var r=Object.keys(e);return r.forEach((function(r){return t(e[r],r,e)}))}if(e instanceof Array)return e.forEach((function(r,n){return t(r,n,e)}));throw new TypeError("Expected either an array or object literal.")}function logger(t){var r=[],n=arguments.length-1;while(n-- >0)r[n]=arguments[n+1];if((this||e).constructor.debug&&console){var i="%cScrollReveal: "+t;r.forEach((function(e){return i+="\n — "+e}));console.log(i,"color: #ea654b;")}}function rinse(){var t=this||e;var struct=function(){return{active:[],stale:[]}};var r=struct();var n=struct();var i=struct();try{each(tealight("[data-sr-id]"),(function(e){var t=parseInt(e.getAttribute("data-sr-id"));r.active.push(t)}))}catch(e){throw e}each((this||e).store.elements,(function(e){-1===r.active.indexOf(e.id)&&r.stale.push(e.id)}));each(r.stale,(function(e){return delete t.store.elements[e]}));each((this||e).store.elements,(function(e){-1===i.active.indexOf(e.containerId)&&i.active.push(e.containerId);e.hasOwnProperty("sequence")&&-1===n.active.indexOf(e.sequence.id)&&n.active.push(e.sequence.id)}));each((this||e).store.containers,(function(e){-1===i.active.indexOf(e.id)&&i.stale.push(e.id)}));each(i.stale,(function(e){var r=t.store.containers[e].node;r.removeEventListener("scroll",t.delegate);r.removeEventListener("resize",t.delegate);delete t.store.containers[e]}));each((this||e).store.sequences,(function(e){-1===n.active.indexOf(e.id)&&n.stale.push(e.id)}));each(n.stale,(function(e){return delete t.store.sequences[e]}))}
/*! @license Rematrix v0.3.0
  		Copyright 2018 Julian Lloyd.
  		Permission is hereby granted, free of charge, to any person obtaining a copy
  	of this software and associated documentation files (the "Software"), to deal
  	in the Software without restriction, including without limitation the rights
  	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  	copies of the Software, and to permit persons to whom the Software is
  	furnished to do so, subject to the following conditions:
  		The above copyright notice and this permission notice shall be included in
  	all copies or substantial portions of the Software.
  		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  	THE SOFTWARE.
  */
/**
   * Transformation matrices in the browser come in two flavors:
   *
   *  - `matrix` using 6 values (short)
   *  - `matrix3d` using 16 values (long)
   *
   * This utility follows this [conversion guide](https://goo.gl/EJlUQ1)
   * to expand short form matrices to their equivalent long form.
   *
   * @param  {array} source - Accepts both short and long form matrices.
   * @return {array}
   */function format(e){if(e.constructor!==Array)throw new TypeError("Expected array.");if(16===e.length)return e;if(6===e.length){var t=identity();t[0]=e[0];t[1]=e[1];t[4]=e[2];t[5]=e[3];t[12]=e[4];t[13]=e[5];return t}throw new RangeError("Expected array with either 6 or 16 values.")}function identity(){var e=[];for(var t=0;t<16;t++)t%5==0?e.push(1):e.push(0);return e}
/**
   * Returns a 4x4 matrix describing the combined transformations
   * of both arguments.
   *
   * > **Note:** Order is very important. For example, rotating 45°
   * along the Z-axis, followed by translating 500 pixels along the
   * Y-axis... is not the same as translating 500 pixels along the
   * Y-axis, followed by rotating 45° along on the Z-axis.
   *
   * @param  {array} m - Accepts both short and long form matrices.
   * @param  {array} x - Accepts both short and long form matrices.
   * @return {array}
   */function multiply(e,t){var r=format(e);var n=format(t);var i=[];for(var o=0;o<4;o++){var a=[r[o],r[o+4],r[o+8],r[o+12]];for(var s=0;s<4;s++){var l=4*s;var c=[n[l],n[l+1],n[l+2],n[l+3]];var u=a[0]*c[0]+a[1]*c[1]+a[2]*c[2]+a[3]*c[3];i[o+l]=u}}return i}
/**
   * Attempts to return a 4x4 matrix describing the CSS transform
   * matrix passed in, but will return the identity matrix as a
   * fallback.
   *
   * > **Tip:** This method is used to convert a CSS matrix (retrieved as a
   * `string` from computed styles) to its equivalent array format.
   *
   * @param  {string} source - `matrix` or `matrix3d` CSS Transform value.
   * @return {array}
   */function parse(e){if("string"===typeof e){var t=e.match(/matrix(3d)?\(([^)]+)\)/);if(t){var r=t[2].split(", ").map(parseFloat);return format(r)}}return identity()}
/**
   * Returns a 4x4 matrix describing X-axis rotation.
   *
   * @param  {number} angle - Measured in degrees.
   * @return {array}
   */function rotateX(e){var t=Math.PI/180*e;var r=identity();r[5]=r[10]=Math.cos(t);r[6]=r[9]=Math.sin(t);r[9]*=-1;return r}
/**
   * Returns a 4x4 matrix describing Y-axis rotation.
   *
   * @param  {number} angle - Measured in degrees.
   * @return {array}
   */function rotateY(e){var t=Math.PI/180*e;var r=identity();r[0]=r[10]=Math.cos(t);r[2]=r[8]=Math.sin(t);r[2]*=-1;return r}
/**
   * Returns a 4x4 matrix describing Z-axis rotation.
   *
   * @param  {number} angle - Measured in degrees.
   * @return {array}
   */function rotateZ(e){var t=Math.PI/180*e;var r=identity();r[0]=r[5]=Math.cos(t);r[1]=r[4]=Math.sin(t);r[4]*=-1;return r}
/**
   * Returns a 4x4 matrix describing 2D scaling. The first argument
   * is used for both X and Y-axis scaling, unless an optional
   * second argument is provided to explicitly define Y-axis scaling.
   *
   * @param  {number} scalar    - Decimal multiplier.
   * @param  {number} [scalarY] - Decimal multiplier.
   * @return {array}
   */function scale(e,t){var r=identity();r[0]=e;r[5]="number"===typeof t?t:e;return r}
/**
   * Returns a 4x4 matrix describing X-axis translation.
   *
   * @param  {number} distance - Measured in pixels.
   * @return {array}
   */function translateX(e){var t=identity();t[12]=e;return t}
/**
   * Returns a 4x4 matrix describing Y-axis translation.
   *
   * @param  {number} distance - Measured in pixels.
   * @return {array}
   */function translateY(e){var t=identity();t[13]=e;return t}var n=function(){var e={};var t=document.documentElement.style;function getPrefixedCssProperty(r,n){void 0===n&&(n=t);if(r&&"string"===typeof r){if(e[r])return e[r];if("string"===typeof n[r])return e[r]=r;if("string"===typeof n["-webkit-"+r])return e[r]="-webkit-"+r;throw new RangeError('Unable to find "'+r+'" style property.')}throw new TypeError("Expected a string.")}getPrefixedCssProperty.clearCache=function(){return e={}};return getPrefixedCssProperty}();function style(e){var t=window.getComputedStyle(e.node);var r=t.position;var i=e.config;var o={};var a=e.node.getAttribute("style")||"";var s=a.match(/[\w-]+\s*:\s*[^;]+\s*/gi)||[];o.computed=s?s.map((function(e){return e.trim()})).join("; ")+";":"";o.generated=s.some((function(e){return e.match(/visibility\s?:\s?visible/i)}))?o.computed:s.concat(["visibility: visible"]).map((function(e){return e.trim()})).join("; ")+";";var l=parseFloat(t.opacity);var c=isNaN(parseFloat(i.opacity))?parseFloat(t.opacity):parseFloat(i.opacity);var u={computed:l!==c?"opacity: "+l+";":"",generated:l!==c?"opacity: "+c+";":""};var d=[];if(parseFloat(i.distance)){var f="top"===i.origin||"bottom"===i.origin?"Y":"X";var v=i.distance;"top"!==i.origin&&"left"!==i.origin||(v=/^-/.test(v)?v.substr(1):"-"+v);var h=v.match(/(^-?\d+\.?\d?)|(em$|px$|%$)/g);var p=h[0];var g=h[1];switch(g){case"em":v=parseInt(t.fontSize)*p;break;case"px":v=p;break;case"%":v="Y"===f?e.node.getBoundingClientRect().height*p/100:e.node.getBoundingClientRect().width*p/100;break;default:throw new RangeError("Unrecognized or missing distance unit.")}"Y"===f?d.push(translateY(v)):d.push(translateX(v))}i.rotate.x&&d.push(rotateX(i.rotate.x));i.rotate.y&&d.push(rotateY(i.rotate.y));i.rotate.z&&d.push(rotateZ(i.rotate.z));1!==i.scale&&(0===i.scale?d.push(scale(2e-4)):d.push(scale(i.scale)));var m={};if(d.length){m.property=n("transform");m.computed={raw:t[m.property],matrix:parse(t[m.property])};d.unshift(m.computed.matrix);var y=d.reduce(multiply);m.generated={initial:m.property+": matrix3d("+y.join(", ")+");",final:m.property+": matrix3d("+m.computed.matrix.join(", ")+");"}}else m.generated={initial:"",final:""};var b={};if(u.generated||m.generated.initial){b.property=n("transition");b.computed=t[b.property];b.fragments=[];var w=i.delay;var j=i.duration;var T=i.easing;u.generated&&b.fragments.push({delayed:"opacity "+j/1e3+"s "+T+" "+w/1e3+"s",instant:"opacity "+j/1e3+"s "+T+" 0s"});m.generated.initial&&b.fragments.push({delayed:m.property+" "+j/1e3+"s "+T+" "+w/1e3+"s",instant:m.property+" "+j/1e3+"s "+T+" 0s"});var E=b.computed&&!b.computed.match(/all 0s|none 0s/);E&&b.fragments.unshift({delayed:b.computed,instant:b.computed});var O=b.fragments.reduce((function(e,t,r){e.delayed+=0===r?t.delayed:", "+t.delayed;e.instant+=0===r?t.instant:", "+t.instant;return e}),{delayed:"",instant:""});b.generated={delayed:b.property+": "+O.delayed+";",instant:b.property+": "+O.instant+";"}}else b.generated={delayed:"",instant:""};return{inline:o,opacity:u,position:r,transform:m,transition:b}}
/**
   * apply a CSS string to an element using the CSSOM (element.style) rather
   * than setAttribute, which may violate the content security policy.
   *
   * @param {Node}   [el]  Element to receive styles.
   * @param {string} [declaration] Styles to apply.
   */function applyStyle(e,t){t.split(";").forEach((function(t){var r=t.split(":");var n=r[0];var i=r.slice(1);n&&i&&(e.style[n.trim()]=i.join(":"))}))}function clean(t){var r=this||e;var n;try{each(tealight(t),(function(e){var t=e.getAttribute("data-sr-id");if(null!==t){n=true;var i=r.store.elements[t];i.callbackTimer&&window.clearTimeout(i.callbackTimer.clock);applyStyle(i.node,i.styles.inline.generated);e.removeAttribute("data-sr-id");delete r.store.elements[t]}}))}catch(t){return logger.call(this||e,"Clean failed.",t.message)}if(n)try{rinse.call(this||e)}catch(t){return logger.call(this||e,"Clean failed.",t.message)}}function destroy(){var t=this||e;each((this||e).store.elements,(function(e){applyStyle(e.node,e.styles.inline.generated);e.node.removeAttribute("data-sr-id")}));each((this||e).store.containers,(function(e){var r=e.node===document.documentElement?window:e.node;r.removeEventListener("scroll",t.delegate);r.removeEventListener("resize",t.delegate)}));(this||e).store={containers:{},elements:{},history:[],sequences:{}}}function deepAssign(e){var t=[],r=arguments.length-1;while(r-- >0)t[r]=arguments[r+1];if(isObject(e)){each(t,(function(t){each(t,(function(t,r){if(isObject(t)){e[r]&&isObject(e[r])||(e[r]={});deepAssign(e[r],t)}else e[r]=t}))}));return e}throw new TypeError("Target must be an object literal.")}function isMobile(e){void 0===e&&(e=navigator.userAgent);return/Android|iPhone|iPad|iPod/i.test(e)}var i=function(){var e=0;return function(){return e++}}();function initialize(){var t=this||e;rinse.call(this||e);each((this||e).store.elements,(function(e){var t=[e.styles.inline.generated];if(e.visible){t.push(e.styles.opacity.computed);t.push(e.styles.transform.generated.final);e.revealed=true}else{t.push(e.styles.opacity.generated);t.push(e.styles.transform.generated.initial);e.revealed=false}applyStyle(e.node,t.filter((function(e){return""!==e})).join(" "))}));each((this||e).store.containers,(function(e){var r=e.node===document.documentElement?window:e.node;r.addEventListener("scroll",t.delegate);r.addEventListener("resize",t.delegate)}));this.delegate();(this||e).initTimeout=null}function animate(t,r){void 0===r&&(r={});var n=r.pristine||(this||e).pristine;var i="always"===t.config.useDelay||"onload"===t.config.useDelay&&n||"once"===t.config.useDelay&&!t.seen;var o=t.visible&&!t.revealed;var a=!t.visible&&t.revealed&&t.config.reset;return r.reveal||o?triggerReveal.call(this||e,t,i):r.reset||a?triggerReset.call(this||e,t):void 0}function triggerReveal(t,r){var n=[t.styles.inline.generated,t.styles.opacity.computed,t.styles.transform.generated.final];r?n.push(t.styles.transition.generated.delayed):n.push(t.styles.transition.generated.instant);t.revealed=t.seen=true;applyStyle(t.node,n.filter((function(e){return""!==e})).join(" "));registerCallbacks.call(this||e,t,r)}function triggerReset(t){var r=[t.styles.inline.generated,t.styles.opacity.generated,t.styles.transform.generated.initial,t.styles.transition.generated.instant];t.revealed=false;applyStyle(t.node,r.filter((function(e){return""!==e})).join(" "));registerCallbacks.call(this||e,t)}function registerCallbacks(t,r){var n=this||e;var i=r?t.config.duration+t.config.delay:t.config.duration;var o=t.revealed?t.config.beforeReveal:t.config.beforeReset;var a=t.revealed?t.config.afterReveal:t.config.afterReset;var s=0;if(t.callbackTimer){s=Date.now()-t.callbackTimer.start;window.clearTimeout(t.callbackTimer.clock)}o(t.node);t.callbackTimer={start:Date.now(),clock:window.setTimeout((function(){a(t.node);t.callbackTimer=null;t.revealed&&!t.config.reset&&t.config.cleanup&&clean.call(n,t.node)}),i-s)}}function sequence(t,r){void 0===r&&(r=(this||e).pristine);if(!t.visible&&t.revealed&&t.config.reset)return animate.call(this||e,t,{reset:true});var n=(this||e).store.sequences[t.sequence.id];var i=t.sequence.index;if(n){var o=new SequenceModel(n,"visible",(this||e).store);var a=new SequenceModel(n,"revealed",(this||e).store);n.models={visible:o,revealed:a};if(!a.body.length){var s=n.members[o.body[0]];var l=(this||e).store.elements[s];if(l){cue.call(this||e,n,o.body[0],-1,r);cue.call(this||e,n,o.body[0],1,r);return animate.call(this||e,l,{reveal:true,pristine:r})}}if(!n.blocked.head&&i===[].concat(a.head).pop()&&i>=[].concat(o.body).shift()){cue.call(this||e,n,i,-1,r);return animate.call(this||e,t,{reveal:true,pristine:r})}if(!n.blocked.foot&&i===[].concat(a.foot).shift()&&i<=[].concat(o.body).pop()){cue.call(this||e,n,i,1,r);return animate.call(this||e,t,{reveal:true,pristine:r})}}}function Sequence(t){var r=Math.abs(t);if(isNaN(r))throw new RangeError("Invalid sequence interval.");(this||e).id=i();(this||e).interval=Math.max(r,16);(this||e).members=[];(this||e).models={};(this||e).blocked={head:false,foot:false}}function SequenceModel(t,r,n){var i=this||e;(this||e).head=[];(this||e).body=[];(this||e).foot=[];each(t.members,(function(e,t){var o=n.elements[e];o&&o[r]&&i.body.push(t)}));(this||e).body.length&&each(t.members,(function(e,t){var o=n.elements[e];o&&!o[r]&&(t<i.body[0]?i.head.push(t):i.foot.push(t))}))}function cue(t,r,n,i){var o=this||e;var a=["head",null,"foot"][1+n];var s=t.members[r+n];var l=(this||e).store.elements[s];t.blocked[a]=true;setTimeout((function(){t.blocked[a]=false;l&&sequence.call(o,l,i)}),t.interval)}function reveal(r,n,o){var a=this||e;void 0===n&&(n={});void 0===o&&(o=false);var s=[];var l;var c=n.interval||t.interval;try{c&&(l=new Sequence(c));var u=tealight(r);if(!u.length)throw new Error("Invalid reveal target.");var d=u.reduce((function(e,t){var r={};var o=t.getAttribute("data-sr-id");if(o){deepAssign(r,a.store.elements[o]);applyStyle(r.node,r.styles.inline.computed)}else{r.id=i();r.node=t;r.seen=false;r.revealed=false;r.visible=false}var c=deepAssign({},r.config||a.defaults,n);if(!c.mobile&&isMobile()||!c.desktop&&!isMobile()){o&&clean.call(a,r);return e}var u=tealight(c.container)[0];if(!u)throw new Error("Invalid container.");if(!u.contains(t))return e;var d;d=getContainerId(u,s,a.store.containers);if(null===d){d=i();s.push({id:d,node:u})}r.config=c;r.containerId=d;r.styles=style(r);if(l){r.sequence={id:l.id,index:l.members.length};l.members.push(r.id)}e.push(r);return e}),[]);each(d,(function(e){a.store.elements[e.id]=e;e.node.setAttribute("data-sr-id",e.id)}))}catch(t){return logger.call(this||e,"Reveal failed.",t.message)}each(s,(function(e){a.store.containers[e.id]={id:e.id,node:e.node}}));l&&((this||e).store.sequences[l.id]=l);if(true!==o){(this||e).store.history.push({target:r,options:n});(this||e).initTimeout&&window.clearTimeout((this||e).initTimeout);(this||e).initTimeout=window.setTimeout(initialize.bind(this||e),0)}}function getContainerId(e){var t=[],r=arguments.length-1;while(r-- >0)t[r]=arguments[r+1];var n=null;each(t,(function(t){each(t,(function(t){null===n&&t.node===e&&(n=t.id)}))}));return n}function sync(){var t=this||e;each((this||e).store.history,(function(e){reveal.call(t,e.target,e.options,true)}));initialize.call(this||e)}var polyfill=function(e){return(e>0)-(e<0)||+e};var o=Math.sign||polyfill;
/*! @license miniraf v1.0.1
  		Copyright 2018 Fisssion LLC.
  		Permission is hereby granted, free of charge, to any person obtaining a copy
  	of this software and associated documentation files (the "Software"), to deal
  	in the Software without restriction, including without limitation the rights
  	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  	copies of the Software, and to permit persons to whom the Software is
  	furnished to do so, subject to the following conditions:
  		The above copyright notice and this permission notice shall be included in all
  	copies or substantial portions of the Software.
  		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  	SOFTWARE.
  	*/var a=function(){var e=Date.now();return function(t){var r=Date.now();if(r-e>16){e=r;t(r)}else setTimeout((function(){return a(t)}),0)}}();var s=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||a;function getGeometry(e,t){var r=t?e.node.clientHeight:e.node.offsetHeight;var n=t?e.node.clientWidth:e.node.offsetWidth;var i=0;var o=0;var a=e.node;do{isNaN(a.offsetTop)||(i+=a.offsetTop);isNaN(a.offsetLeft)||(o+=a.offsetLeft);a=a.offsetParent}while(a);return{bounds:{top:i,right:o+n,bottom:i+r,left:o},height:r,width:n}}function getScrolled(e){var t,r;if(e.node===document.documentElement){t=window.pageYOffset;r=window.pageXOffset}else{t=e.node.scrollTop;r=e.node.scrollLeft}return{top:t,left:r}}function isElementVisible(t){void 0===t&&(t={});var r=(this||e).store.containers[t.containerId];if(r){var n=Math.max(0,Math.min(1,t.config.viewFactor));var i=t.config.viewOffset;var o={top:t.geometry.bounds.top+t.geometry.height*n,right:t.geometry.bounds.right-t.geometry.width*n,bottom:t.geometry.bounds.bottom-t.geometry.height*n,left:t.geometry.bounds.left+t.geometry.width*n};var a={top:r.geometry.bounds.top+r.scroll.top+i.top,right:r.geometry.bounds.right+r.scroll.left-i.right,bottom:r.geometry.bounds.bottom+r.scroll.top-i.bottom,left:r.geometry.bounds.left+r.scroll.left+i.left};return o.top<a.bottom&&o.right>a.left&&o.bottom>a.top&&o.left<a.right||"fixed"===t.styles.position}}function delegate(t,r){var n=this||e;void 0===t&&(t={type:"init"});void 0===r&&(r=(this||e).store.elements);s((function(){var e="init"===t.type||"resize"===t.type;each(n.store.containers,(function(t){e&&(t.geometry=getGeometry.call(n,t,true));var r=getScrolled.call(n,t);t.scroll&&(t.direction={x:o(r.left-t.scroll.left),y:o(r.top-t.scroll.top)});t.scroll=r}));each(r,(function(t){(e||void 0===t.geometry)&&(t.geometry=getGeometry.call(n,t));t.visible=isElementVisible.call(n,t)}));each(r,(function(e){e.sequence?sequence.call(n,e):animate.call(n,e)}));n.pristine=false}))}function isTransformSupported(){var e=document.documentElement.style;return"transform"in e||"WebkitTransform"in e}function isTransitionSupported(){var e=document.documentElement.style;return"transition"in e||"WebkitTransition"in e}var l="4.0.9";var c;var u;var d;var f;var v;var h;var p;var g;function ScrollReveal(n){void 0===n&&(n={});var i="undefined"===typeof(this||e)||Object.getPrototypeOf(this||e)!==ScrollReveal.prototype;if(i)return new ScrollReveal(n);if(!ScrollReveal.isSupported()){logger.call(this||e,"Instantiation failed.","This browser is not supported.");return r.failure()}var o;try{o=deepAssign({},h||t,n)}catch(t){logger.call(this||e,"Invalid configuration.",t.message);return r.failure()}try{var a=tealight(o.container)[0];if(!a)throw new Error("Invalid container.")}catch(t){logger.call(this||e,t.message);return r.failure()}h=o;if(!h.mobile&&isMobile()||!h.desktop&&!isMobile()){logger.call(this||e,"This device is disabled.","desktop: "+h.desktop,"mobile: "+h.mobile);return r.failure()}r.success();(this||e).store={containers:{},elements:{},history:[],sequences:{}};(this||e).pristine=true;c=c||delegate.bind(this||e);u=u||destroy.bind(this||e);d=d||reveal.bind(this||e);f=f||clean.bind(this||e);v=v||sync.bind(this||e);Object.defineProperty(this||e,"delegate",{get:function(){return c}});Object.defineProperty(this||e,"destroy",{get:function(){return u}});Object.defineProperty(this||e,"reveal",{get:function(){return d}});Object.defineProperty(this||e,"clean",{get:function(){return f}});Object.defineProperty(this||e,"sync",{get:function(){return v}});Object.defineProperty(this||e,"defaults",{get:function(){return h}});Object.defineProperty(this||e,"version",{get:function(){return l}});Object.defineProperty(this||e,"noop",{get:function(){return false}});return g||(g=this||e)}ScrollReveal.isSupported=function(){return isTransformSupported()&&isTransitionSupported()};Object.defineProperty(ScrollReveal,"debug",{get:function(){return p||false},set:function(e){return p="boolean"===typeof e?e:p}});ScrollReveal();return ScrollReveal}));var r=t;export default r;

