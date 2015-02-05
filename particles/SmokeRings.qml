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
            lifeSpan: 2000
            enabled: false
            acceleration: PointDirection { y: -5 }
            velocity: AngleDirection { magnitude: 64; angleVariation: 360 }
            size: 24
            sizeVariation: 8

        }

    }
}
