import QtQuick 2.4
import QtQuick.Particles 2.0

ParticleSystem {
    anchors.fill: parent

    Turbulence {
        id: turb
        enabled: true
        height: (parent.height / 2) - 4
        width: parent.width
        x: parent. width / 4
        anchors.fill: parent
        strength: 32
        NumberAnimation on strength{from: 16; to: 64; easing.type: Easing.InOutBounce; duration: 1800; loops: -1}
    }

    ImageParticle {
        groups: ["smoke"]
        source: 'images/glowdot.png'
        color: "#11111111"
        colorVariation: 0
    }

    Emitter {
        anchors.centerIn: parent
        group: "smoke"

        emitRate: 20
        lifeSpan: 1800
        size: 20
        endSize: 10
        sizeVariation: 10
        acceleration: PointDirection { y: -5 }
        velocity: AngleDirection { angle: 270; magnitude: 20; angleVariation: 22; magnitudeVariation: 5 }
    }
}
