import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {

    anchors.fill: parent

    Attractor {
        id: gs; pointX: parent.width*0.35; pointY: parent.height*0.20; strength: 80000;
        affectedParameter: Attractor.Acceleration
        proportionalToDistance: Attractor.InverseQuadratic
    }

    ImageParticle {
        groups: ["smoke"]
        source: 'images/smoke_particle.png'
        color: "black" //"#11111111"
        colorVariation: 0
    }

    Emitter {
        id: smokeEmitter
        anchors.centerIn: parent
        width: parent.width*0.1
        group: "smoke"
        rotation: -25

        emitRate: 100
        lifeSpan: 4000
        size: 20
        endSize: 30
        sizeVariation: 50
        acceleration: PointDirection { y: -3 }
        velocity: AngleDirection { angle: 180+90; magnitude: 50; angleVariation: 20; magnitudeVariation: 10 }
    }
}
