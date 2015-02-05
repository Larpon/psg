import QtQuick 2.4
import QtQuick.Particles 2.0

Item {
    anchors.fill: parent

    property bool lastWasPulse: false

    Timer {
        interval: 1500
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            burstEmitter.burst(500);
            /*
            if (lastWasPulse) {
                burstEmitter.burst(500);
                lastWasPulse = false;
            } else {
                pulseEmitter.pulse(500);
                lastWasPulse = true;
            }
            */
        }
    }

    ParticleSystem {
        id: particles
        anchors.fill: parent

        ImageParticle {
            source: "images/glowdot.png"
            alpha: 0
            color: "#11111111"
            //colorVariation: 0
        }

        Emitter {
            id: burstEmitter

            anchors.centerIn: parent

            emitRate: 1000
            lifeSpan: 500
            enabled: false
            velocity: AngleDirection { magnitude: 264; angleVariation: 360 }
            size: 14
            sizeVariation: 8

        }

        /*
        Emitter {
            id: pulseEmitter
            x: parent.width/2
            y: 2*parent.height/3
            emitRate: 1000
            lifeSpan: 2000
            enabled: false
            velocity: AngleDirection{magnitude: 64; angleVariation: 360}
            size: 24
            sizeVariation: 8
            Text {
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 18
                text: "Pulse"
            }
        }
        */
    }
}
