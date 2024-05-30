extends Node2D

var firstAward :bool = false
var firstStep :bool = true

var firstSpider :bool = false
var firstThread :bool = false
var firstScissors :bool = false
var firstCupOfBeads :bool = false
var firstBead :bool = false
var firstBeadInside :bool = false
var firstSpace :bool = false
var studied :bool = false

var sockets_id :int = 0
enum PLAYER_STUFF {THREAD, BEAD, NONE}

var player_state = PLAYER_STUFF.NONE

