import QtQuick 2.0


Item {
    id: root
    property
    var target
    property int size: 6
    opacity: 0.6

    BorderImage {
        id: img1
        x: target.x - offset
        y: target.y - offset * 0.75

        property int offset: depth_to_size(root.size)

        width: target.width + offset + offset
        height: target.height + offset + offset

        // visible: false

        border {
            left: offset
            top: offset
            right: offset
            bottom: offset
        }
        // opacity: 1 - img1.opacity
        opacity: first_opcaity(root.size)

        source: depth_to_source(root.size)
    }
    BorderImage {
        id: img2
        x: target.x - offset
        y: target.y - offset * 0.75

        property int size: second_size(root.size)

        property int offset: depth_to_size(img2.size)

        width: target.width + offset + offset
        height: target.height + offset + offset

        // visible: false

        border {
            left: offset
            top: offset
            right: offset
            bottom: offset
        }
        // opacity: 1 - img1.opacity
        opacity: second_opacity(root.size)

        source: depth_to_source(img2.size)
    }

    function first_opcaity(depth) {
        if (depth == 5) return 0.72
        if (depth == 7) return 0.72
        if (depth == 10) return 0.84
        if (depth == 11) return 0.59

        if (depth == 13) return 0.88
        if (depth == 14) return 0.72
        if (depth == 15) return 0.46

        if (depth == 17) return 0.95
        if (depth == 18) return 0.88
        if (depth == 19) return 0.81

        if (depth == 20) return 0.72
        if (depth == 21) return 0.62
        if (depth == 22) return 0.46
        if (depth == 23) return 0.30

        return 1
    }

    function second_opacity(depth) {
        if (depth == 5) return 0.5
        if (depth == 7) return 0.5
        if (depth == 10) return 0.33
        if (depth == 11) return 0.66

        if (depth == 13) return 0.25
        if (depth == 14) return 0.5
        if (depth == 15) return 0.75

        if (depth == 17) return 0.125
        if (depth == 18) return 0.25
        if (depth == 19) return 0.375
        if (depth == 20) return 0.5
        if (depth == 21) return 0.625
        if (depth == 22) return 0.75
        if (depth == 23) return 0.875
        return 0
    }

    function second_size(depth) {
        if (depth > 16) return 24
        if (depth > 12) return 16
        if (depth > 9) return 12
        if (depth == 8) return 9
        if (depth > 6) return 8
        if (depth > 4) return 6
        if (depth == 3) return 4
        if (depth == 2) return 3
        if (depth == 1) return 2
        return 1
    }



    function depth_to_source(depth) {
        var number = depth_to_size(depth)
        return "imgs/shadow_" + number + ".png"
    }

    function depth_to_size(depth) {
        if (depth > 23) return 24
        if (depth > 15) return 16
        if (depth > 11) return 12
        if (depth > 8) return 9
        if (depth > 7) return 8
        if (depth > 5) return 6
        if (depth > 3) return 4
        if (depth == 3) return 3
        if (depth == 2) return 2
        if (depth == 1) return 1
        return 1
    }
}