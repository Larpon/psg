pragma Singleton

import QtQuick 2.0

QtObject {
    id: app

    property var __math_abs: Math.abs
    property var __math_random: Math.random
    property var __math_floor: Math.floor
    property var __math_sqrt: Math.sqrt
    property var __math_max: Math.max

    function loopData(object,callback) {
        if(object !== undefined && object !== null) {
            if('data' in object) {
                var data = object.data
                for(var i in data) {
                    callback(data[i])
                    loopData(data[i],callback)
                }
            }
        }
    }

    function loopChildren(object,callback) {
        if(object !== undefined && object !== null) {
            var children = object.children, i
            for(i in children) {
                callback(children[i])
                loopChildren(children[i],callback)
            }
        }
    }

    // These will loop Loader types as well as 'normal' QML objects
    function loopDataDeep(object,callback) {
        if('item' in object && qtypeof(object) === "QQmlTimer")
            object = object.item
        if(object !== undefined && object !== null) {
            if('data' in object) {
                var data = object.data
                for(var i in data) {
                    callback(data[i])
                    loopDataDeep(data[i],callback)
                }
            }
        }
    }

    function loopChildrenDeep(object,callback) {
        if('item' in object && qtypeof(object) === "QQmlTimer")
            object = object.item
        if(object !== undefined && object !== null) {
            var children = object.children, i
            for(i in children) {
                callback(children[i])
                loopChildrenDeep(children[i],callback)
            }
        }
    }

    function loopParent(object,callback) {
        if(object !== undefined && object !== null) {
            var parent = object.parent
            if(parent) {
                callback(parent)
                if(parent.parent)
                    loopParent(parent.parent,callback)
            }
        }
    }

    function remap(oldValue, oldMin, oldMax, newMin, newMax) {
        if(oldMin === newMin && oldMax === newMax)
            return oldValue
        // Linear conversion
        // NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
        return (((oldValue - oldMin) * (newMax - newMin)) / (oldMax - oldMin)) + newMin
    }

    function interpolate(x0, x1, alpha) {
        return (x0 * (1 - alpha) + alpha * x1)
    }

    function lerp(x0, x1, alpha) {
        return interpolate(x0,x1,alpha)
    }

    //Normalizes any number to an arbitrary range
    //by assuming the range wraps around when going below min or above max
    // NOTE untested
    function normalize( value, start, end )
    {
        console.warn('Utility','using untested function normalize')
        var width       = end - start
        var offsetValue = value - start // value relative to 0

        return ( offsetValue - ( __math_floor( offsetValue / width ) * width ) ) + start
        // + start to reset back to start of original range
    }

    // NOTE untested
    function normalize0to360(degrees) {
        console.warn('Utility','using untested function normalize0to360')
        degrees = degrees % 360
        if (degrees < 0)
            degrees += 360
        return degrees
    }

    // Oscillate e.g. "wave" or "ping-pong" between min and max value
    // Integers only
    function oscillate(value, min, max) {
        var range = max - min
        return min + __math_abs(((value + range) % (range * 2)) - range)
    }

    /**
     * Returns a random number between min and max
     */
    function randomRangeArbitary (min, max) {
        return __math_random() * (max - min) + min
    }

    /**
     * Returns a random integer between min and max
     * Using Math.round() will give you a non-uniform distribution!
     */
    function randomRangeInt (min, max) {
        return __math_floor(__math_random() * (max - min + 1)) + min
    }

    function startsWith (haystack, needle) {
        return haystack.lastIndexOf(needle, 0) === 0
    }

    function endsWith (haystack, needle) {
        return needle === haystack.substr(0 - needle.length)
    }

    function objectSize(obj) {
        if(isObject(obj)) {
            var size = 0, key
            for (key in obj) {
                if (key in obj) size++
            }
            return size
        }
        return 0
    }

    function clone(obj) {
        var copy

        // Handle the 3 simple types, and null or undefined
        if (null == obj || "object" != typeof obj) return obj

        // Handle Date
        if (obj instanceof Date) {
            copy = new Date()
            copy.setTime(obj.getTime())
            return copy
        }

        // Handle Array
        if (obj instanceof Array) {
            copy = []
            for (var i = 0, len = obj.length; i < len; i++) {
                copy[i] = clone(obj[i])
            }
            return copy
        }

        // Handle Object
        if (obj instanceof Object) {
            copy = {}
            for (var attr in obj) {
                if (obj.hasOwnProperty(attr)) copy[attr] = clone(obj[attr])
            }
            return copy
        }

        throw new Error("Unable to copy obj! Its type isn't supported.")
    }

    function dump(arr,level) {
        var dumped_text = ""
        if(!level) level = 0

        //The padding given at the beginning of the line.
        var level_padding = ""
        for(var j=0;j<level+1;j++) level_padding += "    "

        if(typeof(arr) == 'object') { //Array/Hashes/Objects
            for(var item in arr) {
                var value = arr[item]

                if(typeof(value) == 'object') { //If it is an array,
                    dumped_text += level_padding + "'" + item + "' ...\n"
                    dumped_text += dump(value,level+1)
                } else {
                    dumped_text += level_padding + "'" + item + "' => \"" + value + "\" "+'('+typeof value+')'+"\n"
                }
            }
        } else { //Stings/Chars/Numbers etc.
            dumped_text = "===>"+arr+"<===("+typeof(arr)+")"
        }
        return dumped_text
    }

    function randomProperty(obj) {
        var keys = Object.keys(obj)
        return obj[keys[ keys.length * __math_random() << 0]]
    }

    function randomFromArray(arr) {
        var key = __math_floor(__math_random() * arr.length)
        return arr[key]
    }

    function shuffle(array) {
      var currentIndex = array.length, temporaryValue, randomIndex

      // While there remain elements to shuffle...
      while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = __math_floor(__math_random() * currentIndex)
        currentIndex -= 1

        // And swap it with the current element.
        temporaryValue = array[currentIndex]
        array[currentIndex] = array[randomIndex]
        array[randomIndex] = temporaryValue
      }

      return array
    }

    function extend(target, source) {
      target = target || {}
      for (var prop in source) {
        if (typeof source[prop] === 'object') {
          target[prop] = extend(target[prop], source[prop])
        } else {
          target[prop] = source[prop]
        }
      }
      return target
    }

    function pad(number, digits, padChar) {
        padChar = padChar || 0
        return new Array(__math_max(digits + 1 - String(number).length + 1, 0)).join(padChar) + number
    }

    function countPad(str, padChar) {
        padChar = padChar || "0"
        var count = 0
        for (var i = 0, len = str.length; i < len; i++) {
            if(str[i] === padChar)
                count++
            else
                break
        }
        // NOTE fixes a string with all zeroes e.g.: '0000'
        if(count === str.length)
            count--
        return count
    }

    // Greatest Common Divisor
    function gcd (a, b) {
        return (b === 0) ? a : gcd (b, a%b)
    }

    function distancePoints(p1,p2) {
        return __math_sqrt( (p1.x-p2.x)*(p1.x-p2.x) + (p1.y-p2.y)*(p1.y-p2.y) )
    }

    function distanceCoordinates(x1,y1,x2,y2) {
        return __math_sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) )
    }

    function isObject(o) {
        return o !== null && typeof o === 'object'
    }

    function isInteger(value) {
      var x
      if (isNaN(value))
        return false
      x = parseFloat(value)
      return (x | 0) === x
    }

    // NOTE WARNING There is currently no official Qt way of getting the QML type of an object as a string - so this might break someday!
    // Further more this won't take QML inheritance into account :(
    function qtypeof(object) {

        if(object === null)
            return 'null'
        if(object === undefined)
            return 'undefined'

        var type = typeof object

        if(type === "object") {
            if('toString' in object && isFunction(object.toString)) {
                type = object.toString()
                //if(type.match(/.*_QMLTYPE_.*/i)) {
                    type = type.replace(/_QMLTYPE_.*/i,'')
                //} else if(type.match(/QQuick.*/i)) {
                    type = type.replace(/\(0x.*\)$/i,'')
                    type = type.replace(/_QML_\d+$/i,'')
                //}
            }
        }
        return type
    }

    function isFunction(v) {
        return (typeof v === "function")
    }

    function isArray(a) {
        return (a instanceof Array)
    }

    function isEmpty(obj) {

        // null and undefined are "empty"
        if (obj === null) return true

        // Assume if it has a length property with a non-zero value
        // that that property is correct.
        if (obj.length > 0)    return false
        if (obj.length === 0)  return true

        // If it isn't an object at this point
        // it is empty, but it can't be anything *but* empty
        // Is it empty?  Depends on your application.
        if (typeof obj !== "object") return true

        // Otherwise, does it have any properties of its own?
        // Note that this doesn't handle
        // toString and valueOf enumeration bugs in IE < 9
        for (var key in obj) {
            if (hasOwnProperty.call(obj, key)) return false
        }

        return true
    }

    function isString(v) {
        return (typeof v === 'string' || v instanceof String)
    }

    function basename(path) {
        return path.split(/[\\/]/).pop()
    }

    // Colors
    function rgbComponentToHex(c) {
        var hex = c.toString(16);
        return hex.length === 1 ? "0" + hex : hex;
    }

    function rgbToHex(r, g, b) {
        return "#" + rgbComponentToHex(r) + rgbComponentToHex(g) + rgbComponentToHex(b);
    }

    function rgbInvert(r,g,b,a) {
        var rgb = []
        rgb.push(r); rgb.push(g); rgb.push(b)
        a = a ? a : 255
        rgb.push(a)
        //rgb = [].slice.call(arguments).join(",").replace(/rgb\(|\)|rgba\(|\)|\s/gi, '').split(',');
        for (var i = 0; i < rgb.length; i++) rgb[i] = (i === 3 ? 1 : 255) - rgb[i];
        return rgbToHex(rgb[0], rgb[1], rgb[2]);
    }

    function colorInvert(color) {
        var rgb = []
        rgb.push(color.r); rgb.push(color.g); rgb.push(color.b)
        //var a = color.a ? rgb.push(color.a) : color.a)
        //rgb = [].slice.call(arguments).join(",").replace(/rgb\(|\)|rgba\(|\)|\s/gi, '').split(',');
        for (var i = 0; i < rgb.length; i++) rgb[i] = (i === 3 ? 1 : 255) - rgb[i];
        return rgbToHex(rgb[0], rgb[1], rgb[2]);
    }

    function shortUID() {
        // I generate the UID from two parts here
        // to ensure the random number provide enough bits.
        var firstPart = (__math_random() * 46656) | 0;
        var secondPart = (__math_random() * 46656) | 0;
        firstPart = ("000" + firstPart.toString(36)).slice(-3);
        secondPart = ("000" + secondPart.toString(36)).slice(-3);
        return firstPart + secondPart;
    }

}
