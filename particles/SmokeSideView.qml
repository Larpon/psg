import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {

    anchors.fill: parent


/*
    Turbulence {
        id: turbulence
        enabled: true

        x: smokeEmitter.x - (width/2)
        y: smokeEmitter.y - (height/2) - 50

        width: 60
        height: 60
        //height: (parent.height / 2) - 4
        //width: parent.width
        //x: parent.width * 0.1
        //anchors.fill: parent
        strength: 32

        NumberAnimation on strength { from: 16; to: 64; easing.type: Easing.InOutBounce; duration: 1800; loops: Animation.Infinite }

        Rectangle { anchors { fill: parent; margins: -5 } color: "tomato"; opacity: 0.1 }

    }
*/

    ImageParticle {
        groups: ["smoke"]
        source: 'images/smoke_particle.png'
        color: "black" //"#11111111"
        colorVariation: 0
    }

    Emitter {
        id: smokeEmitter
        anchors.centerIn: parent
        group: "smoke"

        emitRate: 120
        lifeSpan: 800
        size: 20
        endSize: 10
        sizeVariation: 20
        acceleration: PointDirection { y: -255 }
        velocity: AngleDirection { angle: 180+90; magnitude: 20; angleVariation: 22; magnitudeVariation: 5 }
    }
}
