	<script>
/*
 * Copyright © 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/
		(function() {

			function addEvent( obj, type, fn ) {
				if (obj.addEventListener) {
					obj.addEventListener( type, fn, false );
					EventCache.add(obj, type, fn);
				}
				else if (obj.attachEvent) {
					obj["e"+type+fn] = fn;
					obj[type+fn] = function() { obj["e"+type+fn]( window.event ); }
					obj.attachEvent( "on"+type, obj[type+fn] );
					EventCache.add(obj, type, fn);
				}
				else {
					obj["on"+type] = obj["e"+type+fn];
				}
			}
			
			var EventCache = function(){
				var listEvents = [];
				return {
					listEvents : listEvents,
					add : function(node, sEventName, fHandler){
						listEvents.push(arguments);
					},
					flush : function(){
						var i, item;
						for(i = listEvents.length - 1; i >= 0; i = i - 1){
							item = listEvents[i];
							if(item[0].removeEventListener){
								item[0].removeEventListener(item[1], item[2], item[3]);
							};
							if(item[1].substring(0, 2) != "on"){
								item[1] = "on" + item[1];
							};
							if(item[0].detachEvent){
								item[0].detachEvent(item[1], item[2]);
							};
							item[0][item[1]] = null;
						};
					}
				};
			}();
			
			/** string utility functions **/
			String.prototype.startsWith = function(prefix) {
				return this.indexOf(prefix) === 0;
			};

			String.prototype.endsWith = function(suffix) {
				return this.match(suffix+"$") == suffix;
			};

			function isValidUrl(src) {
				var result = false;
				src = trimStr(src);
				if((src.indexOf("javascript") != 0 && src.indexOf("JAVASCRIPT") != 0) && (src.indexOf(".dsp") != -1 || src.indexOf(".DSP") != -1)) {
					result =  true;
				} else {
					result = false;
				}
				return result;
			}
			
			/** inject tokens as hidden fields into forms **/
			function injectTokenForm(form, tokenName, tokenValue) {
				//we have some forms in our IS which defines action runtime
				//var action = form.getAttribute("action");
				
				//if(action != null) {
					var hidden = document.createElement("input");
					
					hidden.setAttribute("type", "hidden");
					hidden.setAttribute("name", tokenName);
					hidden.setAttribute("value", tokenValue);
					
					form.appendChild(hidden);
				//}
			}

			/** inject tokens as query string parameters into url **/
			function injectTokenAttribute(element, attr, tokenName, tokenValue) {
						
				var location = element.getAttribute(attr);
				
				if(location != null && isValidUrl(location)) {
					var value = (tokenValue);
					
					if(location.indexOf('?') != -1) {
						location = location + '&' + tokenName + '=' + value;
					} else {
						location = location + '?' + tokenName + '=' + value;
					}

					try {
						element.setAttribute(attr, location);
					} catch (e) {
						// attempted to set/update unsupported attribute
					}
				}
			}

			/** inject csrf prevention tokens throughout dom **/
			function injectTokens(tokenName, tokenValue) {
						
				/** iterate over all elements and injection token **/
				var allForms = document.getElementsByTagName('form');
				var len = allForms.length; 
				for(var i=0; i < len; i++) {
					var element = allForms[i];
                    injectTokenForm(element, tokenName, tokenValue);
				} 
				
				var allHREF = document.getElementsByTagName('a'); 
				var len = allHREF.length;

				for(var i=0; i < len; i++) {
					var element = allHREF[i];
                    injectTokenAttribute(element, "href", tokenName, tokenValue);
				} 
			}
			
			function trimStr(str) {
			  return str.replace(/^\s+|\s+$/g, '');
			}

			function hijackStandard() {
				XMLHttpRequest.prototype._open = XMLHttpRequest.prototype.open;
				XMLHttpRequest.prototype.open = function(method, url, async, user, pass) {
					this.url = url;
					
					this._open.apply(this, arguments);
				};
				
				XMLHttpRequest.prototype._send = XMLHttpRequest.prototype.send;
				XMLHttpRequest.prototype.send = function(data) {
					if(this.onsend != null) {
						this.onsend.apply(this, arguments);
					}
					
					this._send.apply(this, arguments);
				};
			}
			
			function hijackExplorer() {
				var _XMLHttpRequest = window.XMLHttpRequest;
				
				function alloc_XMLHttpRequest() {
					this.base = _XMLHttpRequest ? new _XMLHttpRequest : new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				
				function init_XMLHttpRequest() {
					return new alloc_XMLHttpRequest;
				}
				
				init_XMLHttpRequest.prototype = alloc_XMLHttpRequest.prototype;
				
				/** constants **/
				init_XMLHttpRequest.UNSENT = 0;
				init_XMLHttpRequest.OPENED = 1;
				init_XMLHttpRequest.HEADERS_RECEIVED = 2;
				init_XMLHttpRequest.LOADING = 3;
				init_XMLHttpRequest.DONE = 4;
				
				/** properties **/
				init_XMLHttpRequest.prototype.status = 0;
				init_XMLHttpRequest.prototype.statusText = "";
				init_XMLHttpRequest.prototype.readyState = init_XMLHttpRequest.UNSENT;
				init_XMLHttpRequest.prototype.responseText = "";
				init_XMLHttpRequest.prototype.responseXML = null;
				init_XMLHttpRequest.prototype.onsend = null;
				
				init_XMLHttpRequest.url = null;
				init_XMLHttpRequest.onreadystatechange = null;

				/** methods **/
				init_XMLHttpRequest.prototype.open = function(method, url, async, user, pass) {
					var self = this;
					this.url = url;
					
					this.base.onreadystatechange = function() {
						try { self.status = self.base.status; } catch (e) { }
						try { self.statusText = self.base.statusText; } catch (e) { }
						try { self.readyState = self.base.readyState; } catch (e) { }
						try { self.responseText = self.base.responseText; } catch(e) { }
						try { self.responseXML = self.base.responseXML; } catch(e) { }
						
						if(self.onreadystatechange != null) {
							self.onreadystatechange.apply(this, arguments);
						}
					}
					
					this.base.open(method, url, async, user, pass);
				};
				
				init_XMLHttpRequest.prototype.send = function(data) {
					if(this.onsend != null) {
						this.onsend.apply(this, arguments);
					}
					
					this.base.send(data);
				};
				
				init_XMLHttpRequest.prototype.abort = function() {
					this.base.abort();
				};
				
				init_XMLHttpRequest.prototype.getAllResponseHeaders = function() {
					return this.base.getAllResponseHeaders();
				};
				
				init_XMLHttpRequest.prototype.getResponseHeader = function(name) {
					return this.base.getResponseHeader(name);
				};
				
				init_XMLHttpRequest.prototype.setRequestHeader = function(name, value) {
					return this.base.setRequestHeader(name, value);
				};
				
				/** hook **/
				window.XMLHttpRequest = init_XMLHttpRequest;
			}
			
			if(navigator.appName == "Microsoft Internet Explorer") {
				hijackExplorer();
			} else {
				hijackStandard();
			}
			
			XMLHttpRequest.prototype.onsend = function(data) {
				//if(isValidUrl(this.url)) {
				this.setRequestHeader("X-Requested-With", "ajaxRequest");
				this.setRequestHeader(_csrfTokenNm_, _csrfTokenVal_);
				//}
			};
			
			addEvent(window,'unload',EventCache.flush);
			addEvent(window,'load', function() {
				injectTokens(_csrfTokenNm_, _csrfTokenVal_);
			});
			
		})();
	</script>
