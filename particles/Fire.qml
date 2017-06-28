import QtQuick 2.4
import QtQuick.Particles 2.0

ParticleSystem {
    anchors.fill: parent

/*
    Turbulence {
        id: turb
        enabled: true
        height: (parent.height / 2) - 4
        width: parent.width
        x: parent.width / 4
        y: 12
        anchors.fill: parent
        strength: 12
        NumberAnimation on strength { from: 2; to: 14; easing.type: Easing.InOutBounce; duration: 1600; loops: -1}
    }*/


    ImageParticle {
        groups: ["firetop"]
        source: 'images/glowdot.png'
        color: "#ddff400f"
        colorVariation: 0.1
    }

    Emitter {
        anchors.centerIn: parent

        group: "firetop"

        emitRate: 50
        lifeSpan: 950
        size: 25
        endSize: 0
        sizeVariation: 30
        acceleration: PointDirection { y: -255; xVariation: 15; yVariation: 15 }
        velocity: AngleDirection { angle: 180+90; magnitude: 5; angleVariation: 360; magnitudeVariation: 5 }
    }


    ImageParticle {
        groups: ["fire"]
        source: 'images/glowdot.png'
        color: "#22ff400f"
        colorVariation: 0.1
    }

    Emitter {
        anchors.centerIn: parent
        group: "fire"

        emitRate: 220
        lifeSpan: 1200
        size: 10
        endSize: 10
        sizeVariation: 30
        acceleration: PointDirection { y: -255; xVariation: 5; yVariation: 5 }
        velocity: AngleDirection { angle: 180+90; magnitude: 20; angleVariation: 360; magnitudeVariation: 5 }
    }

}
