pragma Singleton

import QtQuick 2.0

import "."

QtObject {
    id: app

    property string name: "Particle Sprite Generator"

    property bool debugging: false
    property bool editing: false

    readonly property bool active: Qt.application.state === Qt.ApplicationActive
    onActiveChanged: debug('App','.active',active) //¤
    property bool paused: !active || !stable
    onPausedChanged: debug('App','.paused',paused) //¤
    property bool stable: false
    onStableChanged: debug('App','.stable',stable) //¤

    //readonly property string version: version
    //readonly property string gitVersion: gitVersion

    readonly property var platform: Qt.platform
    readonly property string os: Qt.platform.os

    readonly property QtObject colors: QtObject {
        property color black: "#000000"
        property color yellow: "#e2c60f"
    }

    //Component.onCompleted: { }

    function connectOnce(target,func) {
        if(!('connect' in target) ||!('disconnect' in target) ) {
            warn('App','::connectOnce',target,'can\'t be connected')
            return
        }
        var f = function() {
            debug('App','::connectOnce','disconnecting') //¤
            target.disconnect(f)
            if(Util.isFunction(func))
                func()
        }
        debug('App','::connectOnce','connecting') //¤
        target.connect(f)
        return { 'disconnect': function(){ target.disconnect(f) }, 'fire':f }
    }

    // NOTE Hacky 'setTimeout' function based on Timer
    readonly property Item __private: Item {
        id: appItem
        Component { id: timerComponent; Timer {} }
        function setTimeout(callback, timeout)
        {
            var timer = timerComponent.createObject(appItem)
            timer.interval = timeout || 0
            timer.triggered.connect(function()
            {
                timer.stop()
                timer.destroy()
                callback()
            })
            timer.start()
        }
    }

    function setTimeout(callback, timeout)
    {
        appItem.setTimeout(callback,timeout)
    }

    function dump(object,filter) {
        filter = filter || []
        var dbgtxt = Aid.qtypeof(object)+":\n"
        for(var j in object) {
            var type = Aid.qtypeof(object[j])
            var propName = j
            if(filter.length > 0 && j in filter) {
                dbgtxt += '"'+propName+'"'+" ("+type+") "+object[j]+"\n"
            } else
                dbgtxt += '"'+propName+'"'+" ("+type+") "+object[j]+"\n"
        }
        debug('App','::dump\n\n',dbgtxt)
    }

    // Logging
    function log() {
        console.log.apply(console, arguments)
    }

    function error() {
        console.error.apply(console, arguments)
    }

    function debug() {
        console.debug.apply(console, arguments)
    }

    function warn() {
        console.warn.apply(console, arguments)
    }

    function info() {
        console.info.apply(console, arguments)
    }

}
