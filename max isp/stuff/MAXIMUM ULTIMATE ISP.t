%Create basic graphics, set background colour
setscreen ("Graphics:500;max")
colorback (black)
drawfillbox (0, 0, maxx, maxy, black)

colour (white)
%By Ansh Sharma


Music.PlayFileLoop ("INTRO_BEAT.mp3")


%Title screen, difficulty level

var intdifficulty : int

var titlephrase : string := "Welcome to Word Shooter"

%Establish procedure that animates text
proc say (phrase : string, speed : int, size : int, position : int)
    var font : int := Font.New ("Lucida Console:" + intstr (size))
    %draw1
    for i : 1 .. length (phrase)

	var spaces : string := ""
	for v : 1 .. i
	    spaces := spaces + " "
	end for

	var textlength : int := Font.Width (phrase, font)

	Draw.Text (spaces + phrase (i), (maxx div 2) - textlength div 2, position, font, white)
	delay (speed)
    end for
end say

%Font list
var thirtyfont : int := Font.New ("Lucida Console:30")
var twentyfivefont : int := Font.New ("Lucida Console:25")
var twentyfont : int := Font.New ("Lucida Console:20")
var fifteenfont : int := Font.New ("Lucida Console:15")

%Establish procedure that keeps text in place for when it is hit
proc staysay (phrase : string, speed : int, size : int, position : int)
    var font : int
    if size = 30 then
	font := thirtyfont
    elsif size = 25 then
	font := twentyfivefont
    elsif size = 20 then
	font := twentyfont
    elsif size = 15 then
	font := fifteenfont
    end if
    %draw1
    for i : 1 .. length (phrase)

	var spaces : string := ""
	for v : 1 .. i
	    spaces := spaces + " "
	end for

	var textlength : int := Font.Width (phrase, font)

	Draw.Text (spaces + phrase (i), (maxx div 2) - textlength div 2, position, font, white)
    end for
end staysay

%Removes text
proc antisay (words : string, speed : int, size : int, position : int)
    var phrase : string := words + " "
    var font : int := Font.New ("Lucida Console:" + intstr (size))
    for i : 1 .. length (phrase)

	var spaces : string := ""
	for v : 1 .. i
	    spaces := spaces + " "
	end for

	var textlength : int := Font.Width (phrase, font)

	drawfillbox ((maxx div 2) - textlength div 2, position - 5, (maxx div 2) - textlength div 2 + Font.Width (phrase (i), font) * i + 6, position + size, black)
	Draw.Text (spaces + phrase (i), (maxx div 2) - textlength div 2, position, font, black)
	delay (speed div 2)
    end for
end antisay

%Introduction screen
proc intro
    say ("Welcome to Word Shooter", 25, 20, 660)
    say ("Press q for instructions.", 25, 13, 630)
    say ("Or choose your difficulty.", 25, 13, 600)
    say ("1 for easy, 2 for medium, 3 for hard.", 25, 13, 570)

end intro

intro

var difficulty : string

%Check input in main menu
var chars : array char of boolean
loop
    Input.KeyDown (chars)

    if chars ('1') then
	difficulty := "1"
	exit
    end if
    if chars ('2') then
	difficulty := "2"
	exit
    end if
    if chars ('3') then
	difficulty := "3"
	exit
    end if
    if chars ('q') then
	%instructions
	antisay ("Welcome to Word Shooter", 25, 20, 660)
	antisay ("Press q for instructions.", 25, 13, 630)
	antisay ("Or choose your difficulty.", 25, 13, 600)
	antisay ("1 for easy, 2 for medium, 3 for hard.", 25, 13, 570)

	say ("Your goal is to answer questions correctly.", 35, 13, 630)
	say ("Use the arrow keys to move your ship.", 35, 13, 600)
	say ("Spacebar shoots a bullet.", 35, 13, 570)
	say ("Shoot the right answer to the given question.", 35, 13, 540)
	say ("You have 10 lives shown at the bottom.", 35, 13, 510)
	say ("Shoot a wrong answer and lose 1 life.", 35, 13, 480)
	say ("Let the correct answer go and you lose 2 lives.", 35, 13, 450)
	say ("Try to go as far as you can.", 35, 13, 420)
	say ("Good luck.", 35, 13, 350)
	delay (3000)

	antisay ("Your goal is to answer questions correctly.", 35, 13, 630)
	antisay ("Use the arrow keys to move your ship.", 35, 13, 600)
	antisay ("Spacebar shoots a bullet.", 35, 13, 570)
	antisay ("Shoot the right answer to the given question.", 35, 13, 540)
	antisay ("You have 10 lives shown at the bottom.", 35, 13, 510)
	antisay ("Shoot a wrong answer and lose 1 life.", 35, 13, 480)
	antisay ("Let the correct answer go and you lose 2 lives.", 35, 13, 450)
	antisay ("Try to go as far as you can.", 35, 13, 420)
	antisay ("Good luck.", 35, 13, 350)

	intro
    end if
end loop

%int version of difficulty
intdifficulty := strint (difficulty)

cls

%Current location of ship
var currentx : int := maxx div 2
var currenty : int := maxy div 2

%Create ship speed, bullet speed
var originalshipspeed : int := 13
var shipspeed : int := originalshipspeed
var bulletspeed : int := 10


% Creates the ship sprite
proc moveship (xgiven : int, ygiven : int)
    View.Set ("offscreenonly")
    var pixsize : int := 3
    var graycolor : int := 30
    var redcolor : int := 40
    var bluecolor : int := 9

    var x : int := xgiven
    var y : int := ygiven

    %clear old ship
    graycolor := black
    redcolor := black
    bluecolor := black

    %Remove old ship. Creates a ship completely black
    drawfillbox (currentx, currenty, currentx + pixsize, currenty + pixsize, graycolor)
    drawfillbox (currentx, currenty + pixsize, currentx + pixsize, currenty + 2 * pixsize, graycolor)
    drawfillbox (currentx, currenty + 2 * pixsize, currentx + pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx, currenty + 3 * pixsize, currentx + pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx, currenty + 4 * pixsize, currentx + pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx, currenty + 5 * pixsize, currentx + pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx, currenty + 6 * pixsize, currentx + pixsize, currenty + 7 * pixsize, redcolor)
    drawfillbox (currentx, currenty + 7 * pixsize, currentx + pixsize, currenty + 8 * pixsize, redcolor)

    drawfillbox (currentx + pixsize, currenty + pixsize, currentx + 2 * pixsize, currenty + 2 * pixsize, graycolor)
    drawfillbox (currentx + pixsize, currenty + 2 * pixsize, currentx + 2 * pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx + pixsize, currenty + 3 * pixsize, currentx + 2 * pixsize, currenty + 4 * pixsize, graycolor)

    drawfillbox (currentx + 2 * pixsize, currenty + 2 * pixsize, currentx + 3 * pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx + 2 * pixsize, currenty + 3 * pixsize, currentx + 3 * pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx + 2 * pixsize, currenty + 4 * pixsize, currentx + 3 * pixsize, currenty + 5 * pixsize, graycolor)

    drawfillbox (currentx + 3 * pixsize, currenty + 4 * pixsize, currentx + 4 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 3 * pixsize, currenty + 5 * pixsize, currentx + 4 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 3 * pixsize, currenty + 6 * pixsize, currentx + 4 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 3 * pixsize, currenty + 7 * pixsize, currentx + 4 * pixsize, currenty + 8 * pixsize, bluecolor)
    drawfillbox (currentx + 3 * pixsize, currenty + 8 * pixsize, currentx + 4 * pixsize, currenty + 9 * pixsize, graycolor)
    drawfillbox (currentx + 3 * pixsize, currenty + 9 * pixsize, currentx + 4 * pixsize, currenty + 10 * pixsize, redcolor)
    drawfillbox (currentx + 3 * pixsize, currenty + 10 * pixsize, currentx + 4 * pixsize, currenty + 11 * pixsize, redcolor)

    drawfillbox (currentx + 4 * pixsize, currenty + 2 * pixsize, currentx + 5 * pixsize, currenty + 3 * pixsize, redcolor)
    drawfillbox (currentx + 4 * pixsize, currenty + 3 * pixsize, currentx + 5 * pixsize, currenty + 4 * pixsize, redcolor)
    drawfillbox (currentx + 4 * pixsize, currenty + 4 * pixsize, currentx + 5 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 4 * pixsize, currenty + 5 * pixsize, currentx + 5 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 4 * pixsize, currenty + 6 * pixsize, currentx + 5 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 4 * pixsize, currenty + 7 * pixsize, currentx + 5 * pixsize, currenty + 8 * pixsize, graycolor)
    drawfillbox (currentx + 4 * pixsize, currenty + 8 * pixsize, currentx + 5 * pixsize, currenty + 9 * pixsize, bluecolor)

    drawfillbox (currentx + 5 * pixsize, currenty + 2 * pixsize, currentx + 6 * pixsize, currenty + 3 * pixsize, redcolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 3 * pixsize, currentx + 6 * pixsize, currenty + 4 * pixsize, redcolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 4 * pixsize, currentx + 6 * pixsize, currenty + 5 * pixsize, redcolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 5 * pixsize, currentx + 6 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 6 * pixsize, currentx + 6 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 7 * pixsize, currentx + 6 * pixsize, currenty + 8 * pixsize, graycolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 8 * pixsize, currentx + 6 * pixsize, currenty + 9 * pixsize, graycolor)
    drawfillbox (currentx + 5 * pixsize, currenty + 9 * pixsize, currentx + 6 * pixsize, currenty + 10 * pixsize, graycolor)

    drawfillbox (currentx + 6 * pixsize, currenty + 3 * pixsize, currentx + 7 * pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 4 * pixsize, currentx + 7 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 5 * pixsize, currentx + 7 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 6 * pixsize, currentx + 7 * pixsize, currenty + 7 * pixsize, redcolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 7 * pixsize, currentx + 7 * pixsize, currenty + 8 * pixsize, redcolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 8 * pixsize, currentx + 7 * pixsize, currenty + 9 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 9 * pixsize, currentx + 7 * pixsize, currenty + 10 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 10 * pixsize, currentx + 7 * pixsize, currenty + 11 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 11 * pixsize, currentx + 7 * pixsize, currenty + 12 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 12 * pixsize, currentx + 7 * pixsize, currenty + 13 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 13 * pixsize, currentx + 7 * pixsize, currenty + 14 * pixsize, graycolor)
    drawfillbox (currentx + 6 * pixsize, currenty + 14 * pixsize, currentx + 7 * pixsize, currenty + 15 * pixsize, graycolor)

    drawfillbox (currentx + 7 * pixsize, currenty + 14 * pixsize, currentx + 8 * pixsize, currenty + 2 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 14 * pixsize, currentx + 8 * pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 3 * pixsize, currentx + 8 * pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 4 * pixsize, currentx + 8 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 5 * pixsize, currentx + 8 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 6 * pixsize, currentx + 8 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 7 * pixsize, currentx + 8 * pixsize, currenty + 8 * pixsize, redcolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 8 * pixsize, currentx + 8 * pixsize, currenty + 9 * pixsize, redcolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 9 * pixsize, currentx + 8 * pixsize, currenty + 10 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 10 * pixsize, currentx + 8 * pixsize, currenty + 11 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 11 * pixsize, currentx + 8 * pixsize, currenty + 12 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 12 * pixsize, currentx + 8 * pixsize, currenty + 13 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 13 * pixsize, currentx + 8 * pixsize, currenty + 14 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 14 * pixsize, currentx + 8 * pixsize, currenty + 15 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 15 * pixsize, currentx + 8 * pixsize, currenty + 16 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 16 * pixsize, currentx + 8 * pixsize, currenty + 17 * pixsize, graycolor)
    drawfillbox (currentx + 7 * pixsize, currenty + 17 * pixsize, currentx + 8 * pixsize, currenty + 18 * pixsize, graycolor)

    drawfillbox (currentx + 8 * pixsize, currenty + 3 * pixsize, currentx + 9 * pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 4 * pixsize, currentx + 9 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 5 * pixsize, currentx + 9 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 6 * pixsize, currentx + 9 * pixsize, currenty + 7 * pixsize, redcolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 7 * pixsize, currentx + 9 * pixsize, currenty + 8 * pixsize, redcolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 8 * pixsize, currentx + 9 * pixsize, currenty + 9 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 9 * pixsize, currentx + 9 * pixsize, currenty + 10 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 10 * pixsize, currentx + 9 * pixsize, currenty + 11 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 11 * pixsize, currentx + 9 * pixsize, currenty + 12 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 12 * pixsize, currentx + 9 * pixsize, currenty + 13 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 13 * pixsize, currentx + 9 * pixsize, currenty + 14 * pixsize, graycolor)
    drawfillbox (currentx + 8 * pixsize, currenty + 14 * pixsize, currentx + 9 * pixsize, currenty + 15 * pixsize, graycolor)

    drawfillbox (currentx + 9 * pixsize, currenty + 2 * pixsize, currentx + 10 * pixsize, currenty + 3 * pixsize, redcolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 3 * pixsize, currentx + 10 * pixsize, currenty + 4 * pixsize, redcolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 4 * pixsize, currentx + 10 * pixsize, currenty + 5 * pixsize, redcolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 5 * pixsize, currentx + 10 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 6 * pixsize, currentx + 10 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 7 * pixsize, currentx + 10 * pixsize, currenty + 8 * pixsize, graycolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 8 * pixsize, currentx + 10 * pixsize, currenty + 9 * pixsize, graycolor)
    drawfillbox (currentx + 9 * pixsize, currenty + 9 * pixsize, currentx + 10 * pixsize, currenty + 10 * pixsize, graycolor)

    drawfillbox (currentx + 10 * pixsize, currenty + 2 * pixsize, currentx + 11 * pixsize, currenty + 3 * pixsize, redcolor)
    drawfillbox (currentx + 10 * pixsize, currenty + 3 * pixsize, currentx + 11 * pixsize, currenty + 4 * pixsize, redcolor)
    drawfillbox (currentx + 10 * pixsize, currenty + 4 * pixsize, currentx + 11 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 10 * pixsize, currenty + 5 * pixsize, currentx + 11 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 10 * pixsize, currenty + 6 * pixsize, currentx + 11 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 10 * pixsize, currenty + 7 * pixsize, currentx + 11 * pixsize, currenty + 8 * pixsize, graycolor)
    drawfillbox (currentx + 10 * pixsize, currenty + 8 * pixsize, currentx + 11 * pixsize, currenty + 9 * pixsize, bluecolor)

    drawfillbox (currentx + 11 * pixsize, currenty + 4 * pixsize, currentx + 12 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 11 * pixsize, currenty + 5 * pixsize, currentx + 12 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 11 * pixsize, currenty + 6 * pixsize, currentx + 12 * pixsize, currenty + 7 * pixsize, graycolor)
    drawfillbox (currentx + 11 * pixsize, currenty + 7 * pixsize, currentx + 12 * pixsize, currenty + 8 * pixsize, bluecolor)
    drawfillbox (currentx + 11 * pixsize, currenty + 8 * pixsize, currentx + 12 * pixsize, currenty + 9 * pixsize, graycolor)
    drawfillbox (currentx + 11 * pixsize, currenty + 9 * pixsize, currentx + 12 * pixsize, currenty + 10 * pixsize, redcolor)
    drawfillbox (currentx + 11 * pixsize, currenty + 10 * pixsize, currentx + 12 * pixsize, currenty + 11 * pixsize, redcolor)

    drawfillbox (currentx + 12 * pixsize, currenty + 2 * pixsize, currentx + 13 * pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx + 12 * pixsize, currenty + 3 * pixsize, currentx + 13 * pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx + 12 * pixsize, currenty + 4 * pixsize, currentx + 13 * pixsize, currenty + 5 * pixsize, graycolor)

    drawfillbox (currentx + 13 * pixsize, currenty + pixsize, currentx + 14 * pixsize, currenty + 2 * pixsize, graycolor)
    drawfillbox (currentx + 13 * pixsize, currenty + 2 * pixsize, currentx + 14 * pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx + 13 * pixsize, currenty + 3 * pixsize, currentx + 14 * pixsize, currenty + 4 * pixsize, graycolor)

    drawfillbox (currentx + 14 * pixsize, currenty, currentx + 15 * pixsize, currenty + pixsize, graycolor)
    drawfillbox (currentx + 14 * pixsize, currenty + pixsize, currentx + 15 * pixsize, currenty + 2 * pixsize, graycolor)
    drawfillbox (currentx + 14 * pixsize, currenty + 2 * pixsize, currentx + 15 * pixsize, currenty + 3 * pixsize, graycolor)
    drawfillbox (currentx + 14 * pixsize, currenty + 3 * pixsize, currentx + 15 * pixsize, currenty + 4 * pixsize, graycolor)
    drawfillbox (currentx + 14 * pixsize, currenty + 4 * pixsize, currentx + 15 * pixsize, currenty + 5 * pixsize, graycolor)
    drawfillbox (currentx + 14 * pixsize, currenty + 5 * pixsize, currentx + 15 * pixsize, currenty + 6 * pixsize, graycolor)
    drawfillbox (currentx + 14 * pixsize, currenty + 6 * pixsize, currentx + 15 * pixsize, currenty + 7 * pixsize, redcolor)
    drawfillbox (currentx + 14 * pixsize, currenty + 7 * pixsize, currentx + 15 * pixsize, currenty + 8 * pixsize, redcolor)


    if x > maxx - 45 then
	x := maxx - 45
    end if
    if y > maxy - 50 then
	y := maxy - 50
    end if
    if y < 80 then
	y := 80
    end if
    if x < 0 then
	x := 0
    end if
    %Change colors
    graycolor := 30
    redcolor := 40
    bluecolor := 9

    %Create an actual ship
    drawfillbox (x, y, x + pixsize, y + pixsize, graycolor)
    drawfillbox (x, y + pixsize, x + pixsize, y + 2 * pixsize, graycolor)
    drawfillbox (x, y + 2 * pixsize, x + pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x, y + 3 * pixsize, x + pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x, y + 4 * pixsize, x + pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x, y + 5 * pixsize, x + pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x, y + 6 * pixsize, x + pixsize, y + 7 * pixsize, redcolor)
    drawfillbox (x, y + 7 * pixsize, x + pixsize, y + 8 * pixsize, redcolor)

    drawfillbox (x + pixsize, y + pixsize, x + 2 * pixsize, y + 2 * pixsize, graycolor)
    drawfillbox (x + pixsize, y + 2 * pixsize, x + 2 * pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x + pixsize, y + 3 * pixsize, x + 2 * pixsize, y + 4 * pixsize, graycolor)

    drawfillbox (x + 2 * pixsize, y + 2 * pixsize, x + 3 * pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x + 2 * pixsize, y + 3 * pixsize, x + 3 * pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x + 2 * pixsize, y + 4 * pixsize, x + 3 * pixsize, y + 5 * pixsize, graycolor)

    drawfillbox (x + 3 * pixsize, y + 4 * pixsize, x + 4 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 3 * pixsize, y + 5 * pixsize, x + 4 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 3 * pixsize, y + 6 * pixsize, x + 4 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 3 * pixsize, y + 7 * pixsize, x + 4 * pixsize, y + 8 * pixsize, bluecolor)
    drawfillbox (x + 3 * pixsize, y + 8 * pixsize, x + 4 * pixsize, y + 9 * pixsize, graycolor)
    drawfillbox (x + 3 * pixsize, y + 9 * pixsize, x + 4 * pixsize, y + 10 * pixsize, redcolor)
    drawfillbox (x + 3 * pixsize, y + 10 * pixsize, x + 4 * pixsize, y + 11 * pixsize, redcolor)

    drawfillbox (x + 4 * pixsize, y + 2 * pixsize, x + 5 * pixsize, y + 3 * pixsize, redcolor)
    drawfillbox (x + 4 * pixsize, y + 3 * pixsize, x + 5 * pixsize, y + 4 * pixsize, redcolor)
    drawfillbox (x + 4 * pixsize, y + 4 * pixsize, x + 5 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 4 * pixsize, y + 5 * pixsize, x + 5 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 4 * pixsize, y + 6 * pixsize, x + 5 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 4 * pixsize, y + 7 * pixsize, x + 5 * pixsize, y + 8 * pixsize, graycolor)
    drawfillbox (x + 4 * pixsize, y + 8 * pixsize, x + 5 * pixsize, y + 9 * pixsize, bluecolor)

    drawfillbox (x + 5 * pixsize, y + 2 * pixsize, x + 6 * pixsize, y + 3 * pixsize, redcolor)
    drawfillbox (x + 5 * pixsize, y + 3 * pixsize, x + 6 * pixsize, y + 4 * pixsize, redcolor)
    drawfillbox (x + 5 * pixsize, y + 4 * pixsize, x + 6 * pixsize, y + 5 * pixsize, redcolor)
    drawfillbox (x + 5 * pixsize, y + 5 * pixsize, x + 6 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 5 * pixsize, y + 6 * pixsize, x + 6 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 5 * pixsize, y + 7 * pixsize, x + 6 * pixsize, y + 8 * pixsize, graycolor)
    drawfillbox (x + 5 * pixsize, y + 8 * pixsize, x + 6 * pixsize, y + 9 * pixsize, graycolor)
    drawfillbox (x + 5 * pixsize, y + 9 * pixsize, x + 6 * pixsize, y + 10 * pixsize, graycolor)

    drawfillbox (x + 6 * pixsize, y + 3 * pixsize, x + 7 * pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 4 * pixsize, x + 7 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 5 * pixsize, x + 7 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 6 * pixsize, x + 7 * pixsize, y + 7 * pixsize, redcolor)
    drawfillbox (x + 6 * pixsize, y + 7 * pixsize, x + 7 * pixsize, y + 8 * pixsize, redcolor)
    drawfillbox (x + 6 * pixsize, y + 8 * pixsize, x + 7 * pixsize, y + 9 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 9 * pixsize, x + 7 * pixsize, y + 10 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 10 * pixsize, x + 7 * pixsize, y + 11 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 11 * pixsize, x + 7 * pixsize, y + 12 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 12 * pixsize, x + 7 * pixsize, y + 13 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 13 * pixsize, x + 7 * pixsize, y + 14 * pixsize, graycolor)
    drawfillbox (x + 6 * pixsize, y + 14 * pixsize, x + 7 * pixsize, y + 15 * pixsize, graycolor)

    drawfillbox (x + 7 * pixsize, y + 14 * pixsize, x + 8 * pixsize, y + 2 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 14 * pixsize, x + 8 * pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 3 * pixsize, x + 8 * pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 4 * pixsize, x + 8 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 5 * pixsize, x + 8 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 6 * pixsize, x + 8 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 7 * pixsize, x + 8 * pixsize, y + 8 * pixsize, redcolor)
    drawfillbox (x + 7 * pixsize, y + 8 * pixsize, x + 8 * pixsize, y + 9 * pixsize, redcolor)
    drawfillbox (x + 7 * pixsize, y + 9 * pixsize, x + 8 * pixsize, y + 10 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 10 * pixsize, x + 8 * pixsize, y + 11 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 11 * pixsize, x + 8 * pixsize, y + 12 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 12 * pixsize, x + 8 * pixsize, y + 13 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 13 * pixsize, x + 8 * pixsize, y + 14 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 14 * pixsize, x + 8 * pixsize, y + 15 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 15 * pixsize, x + 8 * pixsize, y + 16 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 16 * pixsize, x + 8 * pixsize, y + 17 * pixsize, graycolor)
    drawfillbox (x + 7 * pixsize, y + 17 * pixsize, x + 8 * pixsize, y + 18 * pixsize, graycolor)

    drawfillbox (x + 8 * pixsize, y + 3 * pixsize, x + 9 * pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 4 * pixsize, x + 9 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 5 * pixsize, x + 9 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 6 * pixsize, x + 9 * pixsize, y + 7 * pixsize, redcolor)
    drawfillbox (x + 8 * pixsize, y + 7 * pixsize, x + 9 * pixsize, y + 8 * pixsize, redcolor)
    drawfillbox (x + 8 * pixsize, y + 8 * pixsize, x + 9 * pixsize, y + 9 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 9 * pixsize, x + 9 * pixsize, y + 10 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 10 * pixsize, x + 9 * pixsize, y + 11 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 11 * pixsize, x + 9 * pixsize, y + 12 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 12 * pixsize, x + 9 * pixsize, y + 13 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 13 * pixsize, x + 9 * pixsize, y + 14 * pixsize, graycolor)
    drawfillbox (x + 8 * pixsize, y + 14 * pixsize, x + 9 * pixsize, y + 15 * pixsize, graycolor)

    drawfillbox (x + 9 * pixsize, y + 2 * pixsize, x + 10 * pixsize, y + 3 * pixsize, redcolor)
    drawfillbox (x + 9 * pixsize, y + 3 * pixsize, x + 10 * pixsize, y + 4 * pixsize, redcolor)
    drawfillbox (x + 9 * pixsize, y + 4 * pixsize, x + 10 * pixsize, y + 5 * pixsize, redcolor)
    drawfillbox (x + 9 * pixsize, y + 5 * pixsize, x + 10 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 9 * pixsize, y + 6 * pixsize, x + 10 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 9 * pixsize, y + 7 * pixsize, x + 10 * pixsize, y + 8 * pixsize, graycolor)
    drawfillbox (x + 9 * pixsize, y + 8 * pixsize, x + 10 * pixsize, y + 9 * pixsize, graycolor)
    drawfillbox (x + 9 * pixsize, y + 9 * pixsize, x + 10 * pixsize, y + 10 * pixsize, graycolor)

    drawfillbox (x + 10 * pixsize, y + 2 * pixsize, x + 11 * pixsize, y + 3 * pixsize, redcolor)
    drawfillbox (x + 10 * pixsize, y + 3 * pixsize, x + 11 * pixsize, y + 4 * pixsize, redcolor)
    drawfillbox (x + 10 * pixsize, y + 4 * pixsize, x + 11 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 10 * pixsize, y + 5 * pixsize, x + 11 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 10 * pixsize, y + 6 * pixsize, x + 11 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 10 * pixsize, y + 7 * pixsize, x + 11 * pixsize, y + 8 * pixsize, graycolor)
    drawfillbox (x + 10 * pixsize, y + 8 * pixsize, x + 11 * pixsize, y + 9 * pixsize, bluecolor)

    drawfillbox (x + 11 * pixsize, y + 4 * pixsize, x + 12 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 11 * pixsize, y + 5 * pixsize, x + 12 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 11 * pixsize, y + 6 * pixsize, x + 12 * pixsize, y + 7 * pixsize, graycolor)
    drawfillbox (x + 11 * pixsize, y + 7 * pixsize, x + 12 * pixsize, y + 8 * pixsize, bluecolor)
    drawfillbox (x + 11 * pixsize, y + 8 * pixsize, x + 12 * pixsize, y + 9 * pixsize, graycolor)
    drawfillbox (x + 11 * pixsize, y + 9 * pixsize, x + 12 * pixsize, y + 10 * pixsize, redcolor)
    drawfillbox (x + 11 * pixsize, y + 10 * pixsize, x + 12 * pixsize, y + 11 * pixsize, redcolor)

    drawfillbox (x + 12 * pixsize, y + 2 * pixsize, x + 13 * pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x + 12 * pixsize, y + 3 * pixsize, x + 13 * pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x + 12 * pixsize, y + 4 * pixsize, x + 13 * pixsize, y + 5 * pixsize, graycolor)

    drawfillbox (x + 13 * pixsize, y + pixsize, x + 14 * pixsize, y + 2 * pixsize, graycolor)
    drawfillbox (x + 13 * pixsize, y + 2 * pixsize, x + 14 * pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x + 13 * pixsize, y + 3 * pixsize, x + 14 * pixsize, y + 4 * pixsize, graycolor)

    drawfillbox (x + 14 * pixsize, y, x + 15 * pixsize, y + pixsize, graycolor)
    drawfillbox (x + 14 * pixsize, y + pixsize, x + 15 * pixsize, y + 2 * pixsize, graycolor)
    drawfillbox (x + 14 * pixsize, y + 2 * pixsize, x + 15 * pixsize, y + 3 * pixsize, graycolor)
    drawfillbox (x + 14 * pixsize, y + 3 * pixsize, x + 15 * pixsize, y + 4 * pixsize, graycolor)
    drawfillbox (x + 14 * pixsize, y + 4 * pixsize, x + 15 * pixsize, y + 5 * pixsize, graycolor)
    drawfillbox (x + 14 * pixsize, y + 5 * pixsize, x + 15 * pixsize, y + 6 * pixsize, graycolor)
    drawfillbox (x + 14 * pixsize, y + 6 * pixsize, x + 15 * pixsize, y + 7 * pixsize, redcolor)
    drawfillbox (x + 14 * pixsize, y + 7 * pixsize, x + 15 * pixsize, y + 8 * pixsize, redcolor)

    currentx := x
    currenty := y
    %update the ship location
    View.UpdateArea (x - shipspeed, y - shipspeed, x + 45 + shipspeed, y + 55 + shipspeed)
end moveship

var firedelay : boolean := false

%Create a delay system for when you shoot
process enableshoot
    delay (200)
    firedelay := false
end enableshoot
%establish health
var health : int := 10

%draw battery
proc drawbattery (x : int, y : int, col : int)
    var col2 : int
    var xsize : int := 36
    var ysize : int := 66
    var roundsize : int := 4

    if col = white then
	col2 := 40
	drawfillbox (x + roundsize, y, x + xsize - roundsize, y + ysize, col)
	drawfillbox (x, y + roundsize, x + xsize, y + ysize - roundsize, col)
	for i : 1 .. 10
	    drawline (x + 8 + i, y + 29, x + 8 + i, y + 29 + i * 2, col2)
	    drawline (x + 28 - i, y + 37, x + 28 - i, y + 37 - i * 2, col2)
	end for
    end if
    if col = black then
	drawfillbox (x + roundsize, y, x + xsize - roundsize, y + ysize, col)
	drawfillbox (x, y + roundsize, x + xsize, y + ysize - roundsize, col)

    end if

end drawbattery

%procedure that displays your health by drawing a battery
proc displayhealthbar
    for i : 1 .. 10
	if i <= health then
	    drawbattery (maxx - (maxx div 10) * i, 10, white)
	else
	    drawbattery (maxx - (maxx div 10) * i, 10, black)
	end if
    end for

end displayhealthbar

%extra process, just in case
process extradisplayhealthbar
    delay (1500)
    for i : 1 .. 10
	if i <= health then
	    drawbattery (maxx - (maxx div 10) * i, 10, white)
	else
	    drawbattery (maxx - (maxx div 10) * i, 10, black)
	end if
    end for

end extradisplayhealthbar

displayhealthbar

%process that creates a line that fades over time, to be used with firework
process fadingthickline (x1 : int, y1 : int, x2 : int, y2 : int, thickness : int, hue : int)
    Draw.ThickLine (x1, y1, x2, y2, thickness, hue)
    delay (500)
    var newcolor : int := hue
    %reds
    if newcolor = 0 then
	newcolor := 24
    elsif newcolor = 44 then
	newcolor := 116
    elsif newcolor = 43 then
	newcolor := 115
    elsif newcolor = 42 then
	newcolor := 114
    elsif newcolor = 41 then
	newcolor := 113
	%blues
    elsif newcolor = 31 then
	newcolor := 24
    elsif newcolor = 52 then
	newcolor := 124
    elsif newcolor = 53 then
	newcolor := 125
    elsif newcolor = 54 then
	newcolor := 126
    elsif newcolor = 55 then
	newcolor := 127
    end if
    Draw.ThickLine (x1, y1, x2, y2, thickness, newcolor)
    delay (500)
    if newcolor = 24 then
	newcolor := 18
    elsif newcolor = 116 then
	newcolor := 188
    elsif newcolor = 115 then
	newcolor := 187
    elsif newcolor = 114 then
	newcolor := 186
    elsif newcolor = 113 then
	newcolor := 185

    elsif newcolor = 24 then
	newcolor := 194
    elsif newcolor = 124 then
	newcolor := 195
    elsif newcolor = 125 then
	newcolor := 196
    elsif newcolor = 126 then
	newcolor := 197
    elsif newcolor = 127 then
	newcolor := 198
    end if
    Draw.ThickLine (x1, y1, x2, y2, thickness, newcolor)
    delay (500)
    newcolor := black
    Draw.ThickLine (x1, y1, x2, y2, thickness, newcolor)
end fadingthickline

%process that creates a firework using parabolas and lines
process firework (x : int, y : int, col : int, distance : int)

    var centerx : int := x
    var centery : int := y
    var beamx : int
    var beamy : int
    var magnification : real := (Rand.Int (1, 200)) / 1000
    var fireworksize : int := 6
    var fireworkcolor : int := 0

    var direction : int := round (Rand.Real)
    %parabola
    var counter : int := 0
    var fakebeamx : int := centerx
    loop
	counter := counter + 1
	fakebeamx := centerx + counter
	var fakebeamy : int := round (-magnification * (fakebeamx - centerx + Rand.Int (1, 20)) ** 2 + centery)
	if fakebeamy < distance then
	    exit
	end if
    end loop

    for i : 1 .. counter
	if direction = 1 then
	    beamx := centerx + i
	elsif direction = 0 then
	    beamx := centerx - i
	end if
	beamy := round (-magnification * (beamx - centerx + Rand.Int (1, 20)) ** 2 + centery)

	var stage : int := counter div 5

	if col = red then
	    if i < stage then
		fireworksize := 5
		fireworkcolor := 0
	    elsif i < stage * 2 and i > stage then
		fireworksize := 4
		fireworkcolor := 44
	    elsif i < stage * 3 and i > stage * 2 then
		fireworksize := 3
		fireworkcolor := 43
	    elsif i < stage * 4 and i > stage * 3 then
		fireworksize := 2
		fireworkcolor := 42
	    elsif i < stage * 5 and i > stage * 4 then
		fireworksize := 1
		fireworkcolor := 41
	    end if
	elsif col = blue then
	    if i < stage then
		fireworksize := 5
		fireworkcolor := 31
	    elsif i < stage * 2 and i > stage then
		fireworksize := 4
		fireworkcolor := 52
	    elsif i < stage * 3 and i > stage * 2 then
		fireworksize := 3
		fireworkcolor := 53
	    elsif i < stage * 4 and i > stage * 3 then
		fireworksize := 2
		fireworkcolor := 54
	    elsif i < stage * 5 and i > stage * 4 then
		fireworksize := 1
		fireworkcolor := 55
	    end if
	end if

	if col = blue then
	    fireworksize := fireworksize div 2
	end if

	if i > 1 then
	    if direction = 1 then
		var oldbeamx : int := centerx + i - 1
		var oldbeamy : int := round (-magnification * (oldbeamx - centerx) ** 2 + centery)
		fork fadingthickline (oldbeamx, oldbeamy, beamx, beamy, fireworksize, fireworkcolor)
	    elsif direction = 0 then
		var oldbeamx : int := centerx - i + 1
		var oldbeamy : int := round (-magnification * (oldbeamx - centerx) ** 2 + centery)
		fork fadingthickline (oldbeamx, oldbeamy, beamx, beamy, fireworksize, fireworkcolor)
	    end if

	end if
	delay (10)
    end for

end firework

var stopmoving : boolean := false

%creates a firework at ship location
proc blowuphealth
    for i : 1 .. 10
	fork firework (currentx + 7 * 5, currenty + 8 * 5, blue, 0)
    end for
    shipspeed := 5
    delay (2000)
    shipspeed := originalshipspeed
end blowuphealth

%font and enemy id for enemies
var enemyfont : int := Font.New ("Lucida Console:14")
var enemyname : int := 1

%coordinate system for enemies, as well as information on their id
var enemybox : flexible array 1 .. 0, 1 .. 6 of int
new enemybox, 1, 6
for i : 1 .. 6
    enemybox (1, i) := 0
end for

var correctshot : boolean := false

%establish where the ship is
moveship (currentx, currenty)

%level settings
var levelcompleted : int := 0
var correctanswer : boolean := false

%game over boolean
var gameove : boolean := false

% enemy appears


var enemyspeed : int

%create enemy speed based on difficulty
if intdifficulty = 1 then
    enemyspeed := 10
elsif intdifficulty = 2 then
    enemyspeed := 15
elsif intdifficulty = 3 then
    enemyspeed := 17
end if

%create an enemy
process createenemy (x : int, text : string, correct : boolean)
    var enemyx : int := x
    var enemyy : int := maxy
    var currentenemyx : int := enemyx
    var currentenemyy : int := enemyy
    var name := enemyname
    enemyname := enemyname + 1

    var dead : boolean := false

    %distance is amount of steps it takes for text to reach end
    var distance : int := ((maxy - maxy div 8) div enemyspeed)


    %a for for each step the enemy takes
    for estage : 1 .. distance
	%hitboxes
	var hitboxx1 : int := enemyx
	var hitboxy1 : int := currentenemyy
	var hitboxx2 : int := enemyx + ((length (text)) * 12)
	var hitboxy2 : int := currentenemyy + 14
	var enemydimension : int
	%clear old text
	drawfillbox (currentenemyx, currentenemyy + enemyspeed, currentenemyx + Font.Width (text, enemyfont), currentenemyy + enemyspeed + 17, black)

	var oldcodefound : boolean := false     %check if enemy exists already
	oldcodefound := false
	for i : 1 .. upper (enemybox)
	    if enemybox (i, 1) = name then
		oldcodefound := true
		enemydimension := i
	    end if
	end for

	if oldcodefound = true then
	    var n : int := enemybox (enemydimension, 6)             %check if dead, become dead
	    if n = 1 or levelcompleted = 1 or levelcompleted = 2 then
		dead := true
	    end if
	end if
	%create new text
	Draw.Text (text, currentenemyx, currentenemyy, enemyfont, white)
	currentenemyy := currentenemyy - enemyspeed

	if oldcodefound = true then     %replace code if it exists
	    for i : 1 .. 6
		enemybox (enemydimension, 1) := name
		enemybox (enemydimension, 2) := hitboxx1
		enemybox (enemydimension, 3) := hitboxy1
		enemybox (enemydimension, 4) := hitboxx2
		enemybox (enemydimension, 5) := hitboxy2
		enemybox (enemydimension, 6) := 0
	    end for
	else
	    new enemybox, upper (enemybox, 1) + 1, 6
	    enemybox (upper (enemybox), 1) := name     %create code if nonexistant
	    enemybox (upper (enemybox), 2) := hitboxx1
	    enemybox (upper (enemybox), 3) := hitboxy1
	    enemybox (upper (enemybox), 4) := hitboxx2
	    enemybox (upper (enemybox), 5) := hitboxy2
	    enemybox (upper (enemybox), 6) := 0
	end if

	displayhealthbar %show health bar every movement
	delay (50)
	if estage = distance or dead = true or gameove = true then             % delete current code (only on last stage or when dead)
	    drawfillbox (currentenemyx, currentenemyy + enemyspeed, currentenemyx + Font.Width (text, enemyfont), currentenemyy + enemyspeed + 17, black)

	    Draw.Text (text, currentenemyx, currentenemyy + enemyspeed, enemyfont, black)

	    if gameove = true then
		for i : 1 .. 10
		    fork firework (currentenemyx + ((length (text)) * Rand.Int (4, 8)), currentenemyy, red, 0 + maxy div 8) %destroy if game over
		end for
		exit
	    end if

	    if estage = distance and correct = true then
		levelcompleted := 2
		health := health - 2 %lower health if passed end and correct answer
		for i : 1 .. 10
		    displayhealthbar
		end for
		blowuphealth

	    end if

	    if dead = true then     %dead
		color (white)
		for i : 1 .. 10
		    fork firework (currentenemyx + ((length (text)) * Rand.Int (4, 8)), currentenemyy, red, 0 + maxy div 8) %create firework when shot
		end for
		if correct = true then %level up if correct
		    levelcompleted := 1
		elsif correct = false and levelcompleted = 0 then
		    health := health - 1
		    for i : 1 .. 10 %hurt if wrong
			displayhealthbar
		    end for
		    blowuphealth
		    fork extradisplayhealthbar
		end if
		exit
	    end if
	end if
    end for
end createenemy

var bulletsize : int := 7
%shoot bullet
process bulletshoot (x : int, y : int)
    var bulletx : int := x + 22
    var bullety : int := y + 70
    var bulletspeed : int := 30
    var currentbx : int := bulletx
    var currentby : int := bullety
    firedelay := true
    for bstage : 1 .. 50

	var destroyed : boolean := false

	if bstage > 1 then
	    drawfilloval (currentbx, currentby - bulletspeed, bulletsize, bulletsize, black) %remove old bullet image
	end if
	if bstage = 1 then
	    fork enableshoot %bullet delay enable
	end if
	drawfilloval (currentbx, currentby, bulletsize, bulletsize, yellow) %create bullet image

	for unique : 1 .. upper (enemybox, 1)
	    var hitboxx1 : int := enemybox (unique, 2) %get each enemy's coordinates, match up bullet to compare
	    var hitboxy1 : int := enemybox (unique, 3)
	    var hitboxx2 : int := enemybox (unique, 4)
	    var hitboxy2 : int := enemybox (unique, 5)
	    var deadhorse : int := enemybox (unique, 6)

	    if (currentbx > hitboxx1 - bulletsize or currentbx > hitboxx1 + bulletsize) and
		    (currentbx < hitboxx2 + bulletsize or currentbx < hitboxx2 - bulletsize) and
		    (currentby > hitboxy1 + 2 * bulletsize or currentby > hitboxy1 - 2 * bulletsize) and
		    (currentby < hitboxy2 + 2 * bulletsize or currentby < hitboxy2 - 2 * bulletsize) then
		if deadhorse = 0 then
		    enemybox (unique, 6) := 1
		    destroyed := true
		    drawfilloval (currentbx, currentby, bulletsize, bulletsize, black) %if hitboxes match, then make the enemy dead
		end if
	    end if
	end for
	if destroyed = true then
	    exit
	end if
	currentby := currentby + bulletspeed
	delay (50)
    end for
end bulletshoot

process gameover %game over - create fireworks everywhere and say "game over"
    say ("Game Over", 30, 20, 660)
    loop
	var randx : int := Rand.Int (0, maxx)
	var randy : int := Rand.Int (300, maxy)
	for i : 1 .. 20
	    fork firework (randx, randy, blue, 0)
	end for

	for i : 1 .. ((Rand.Int (100, 600)) div 100)
	    staysay ("Game Over", 30, 20, 660)
	    delay (100)
	end for
    end loop
end gameover

%register keys and move
process moving
    var chars : array char of boolean
    var moved : boolean := false
    loop
	Input.KeyDown (chars)
	if gameove = false then
	    if chars (KEY_UP_ARROW) or chars ('w') then %if a movement key is pressed, then move ship
		moveship (currentx, currenty + shipspeed)
		moved := true
	    end if
	    if chars (KEY_RIGHT_ARROW) or chars ('d') then
		moveship (currentx + shipspeed, currenty)
		moved := true
	    end if
	    if chars (KEY_LEFT_ARROW) or chars ('a') then
		moveship (currentx - shipspeed, currenty)
		moved := true
	    end if
	    if chars (KEY_DOWN_ARROW) or chars ('s') then
		moveship (currentx, currenty - shipspeed)
		moved := true
	    end if
	    if moved = false then
		moveship (currentx, currenty)
	    end if
	end if
	View.Update
	if chars (' ') and firedelay = false then
	    fork bulletshoot (currentx, currenty)
	end if
	if chars ('e') then %if e is pressed, then display enemy information (for debugging)
	    colour (white)
	    for i : 2 .. upper (enemybox, 1)
		put i, " " ..
		put "(" ..
		for v : 1 .. 6
		    put enemybox (i, v), "," ..
		end for
		put "), " ..
	    end for
	    put ""
	end if

	if health <= 0 and gameove = false then %game over if health is 0
	    fork gameover
	    gameove := true
	end if

	delay (30)
	if stopmoving = true then %stop the ship and program if stopmoving is true
	    loop
		delay (100)
		exit when stopmoving = false
	    end loop
	end if
    end loop
end moving

View.Update
fork moving

var questions : array 1 .. 2, 1 .. 20, 1 .. 11 of string %list of questions

%randomize math questions
proc randomizequestion (number : int, subject : string)

    if subject = "math" then
	var operation : int := Rand.Int (1, 20)
	var firstnumber : int
	var secondnumber : int
	var answer : int
	var operator : string %determine operator

	loop

	    if operation = 1 or operation = 2 or operation = 3 or operation = 4 or operation = 5 or operation = 6 then %addition
		firstnumber := Rand.Int (1, 10 ** (intdifficulty + 1))
		secondnumber := Rand.Int (1, 10 * intdifficulty)
		answer := firstnumber + secondnumber
		operator := "+"
		exit when answer > 0

	    elsif operation = 7 or operation = 8 or operation = 9 or operation = 10 or operation = 11 or operation = 12 then %subtraction
		firstnumber := Rand.Int (1, 10 ** (intdifficulty + 1))
		secondnumber := Rand.Int (1, 5 * intdifficulty)
		answer := firstnumber - secondnumber
		operator := "-"
		exit when answer > 0
	    elsif operation = 13 or operation = 14 or operation = 15 or operation = 16 or operation = 17 or operation = 18 then %multiplication
		firstnumber := Rand.Int (1, 5 * intdifficulty)
		secondnumber := Rand.Int (1, 3 * intdifficulty)
		answer := firstnumber * secondnumber
		operator := "*"

		exit when answer > 0
	    elsif operation = 19 or operation = 20 then %division
		loop
		    firstnumber := Rand.Int (1, 20 * intdifficulty)
		    secondnumber := Rand.Int (2, 4 * intdifficulty)
		    exit when firstnumber mod secondnumber = 0
		end loop
		answer := firstnumber div secondnumber
		operator := "/"
		exit when answer > 0
	    end if

	end loop

	questions (1, number, 1) := intstr (firstnumber) + " " + operator + " " + intstr (secondnumber) + " = ?" %do the operation and establish answer
	questions (1, number, 2) := intstr (answer)
	for i : 1 .. 9
	    var loworhigh : int := Rand.Int (1, 2)
	    if loworhigh = 1 then
		if answer = 1 then
		    questions (1, number, i + 2) := intstr (Rand.Int (answer + 1, 10 ** (length (intstr (answer))))) %make a random answer thats above the answer
		else
		    questions (1, number, i + 2) := intstr (Rand.Int (0, answer - 1)) %make a random answer that is below the answer
		end if
	    elsif loworhigh = 2 then
		questions (1, number, i + 2) := intstr (Rand.Int (answer + 1, 10 ** (length (intstr (answer)))))
	    end if
	end for
    end if


end randomizequestion

var wordquestions : array 2 .. 4, 1 .. 20, 1 .. 2 of string %science questions

wordquestions (2, 1, 1) := "Element Li stands for ?"
wordquestions (2, 1, 2) := "Lithium"

wordquestions (2, 2, 1) := "Element N stands for ?"
wordquestions (2, 2, 2) := "Nitrogen"

wordquestions (2, 3, 1) := "Element Se stands for ?"
wordquestions (2, 3, 2) := "Selenium"

wordquestions (2, 4, 1) := "Element K stands for ?"
wordquestions (2, 4, 2) := "Potassium"

wordquestions (2, 5, 1) := "Element Pb stands for ?"
wordquestions (2, 5, 2) := "Lead"

wordquestions (2, 6, 1) := "Element Ag stands for ?"
wordquestions (2, 6, 2) := "Silver"

wordquestions (2, 7, 1) := "Element Na stands for ?"
wordquestions (2, 7, 2) := "Sodium"

wordquestions (2, 8, 1) := "A proton is _____ charged"
wordquestions (2, 8, 2) := "Positively"

wordquestions (2, 9, 1) := "A neutron is _____ charged"
wordquestions (2, 9, 2) := "Neutrally"

wordquestions (2, 10, 1) := "An electron is _____ charged"
wordquestions (2, 10, 2) := "Negatively"

wordquestions (2, 11, 1) := "Sodium Bromide is a _____ bond"
wordquestions (2, 11, 2) := "Ionic"

wordquestions (2, 12, 1) := "Atoms spread apart the most in a?"
wordquestions (2, 12, 2) := "Gas"

wordquestions (2, 13, 1) := "Bases have pH levels..."
wordquestions (2, 13, 2) := "Above 7"

wordquestions (2, 14, 1) := "Neutralize an acid and base to form?"
wordquestions (2, 14, 2) := "Water and a salt"

wordquestions (2, 15, 1) := "Carbon Dioxide is a _____ bond."
wordquestions (2, 15, 2) := "Covalent"

wordquestions (2, 16, 1) := "Magnesium is in what periodic group?"
wordquestions (2, 16, 2) := "Earth Alkali Metals"

wordquestions (2, 17, 1) := "Argon is in what periodic group?"
wordquestions (2, 17, 2) := "Noble gases"

wordquestions (2, 18, 1) := "Chlorine is in what periodic group?"
wordquestions (2, 18, 2) := "Halogens"

wordquestions (2, 19, 1) := "What type of metal is iron?"
wordquestions (2, 19, 2) := "Transition Metal"

wordquestions (2, 20, 1) := "Ammonia is what kind of ion?"
wordquestions (2, 20, 2) := "Polyatomic"

for i : 1 .. 20 %put the science questions into the main questions array
    var question : string := wordquestions (2, i, 1)
    var answer : string := wordquestions (2, i, 2)
    questions (2, i, 1) := question
    questions (2, i, 2) := answer
    for v : 1 .. 9
	var randanswer : int
	loop
	    randanswer := Rand.Int (1, 20)
	    exit when answer not= wordquestions (2, randanswer, 2)
	end loop
	questions (2, i, v + 2) := wordquestions (2, randanswer, 2)
    end for
end for

for i : 1 .. 20 %randomize questions
    randomizequestion (i, "math")
end for

var currentlevel : int := 0 %level the player is currently on

proc givequestion (subject : int, question : int) %gives a question to the player. manages overal level account and the enemies that fly towards the player
    currentlevel += 1
    say ("Level " + intstr (currentlevel), 30, 20, 700)
    say (questions (subject, question, 1), 25, 15, 660)
    for i : 1 .. 25
	staysay ("Level " + intstr (currentlevel), 30, 20, 700)
	staysay (questions (subject, question, 1), 25, 15, 660)
	delay (100)
    end for
    antisay ("Level " + intstr (currentlevel), 30, 20, 700)
    antisay (questions (subject, question, 1), 25, 15, 660)
    moveship (currentx, currenty)

    var enemycount : int
    var hardness : int
    if intdifficulty = 1 then
	hardness := 4
	enemycount := 10
    elsif intdifficulty = 2 then
	hardness := 7
	enemycount := 15
    elsif intdifficulty = 3 then
	hardness := 11
	enemycount := 20
    end if

    var randanswer : int := Rand.Int (1, hardness)
    for i : 1 .. enemycount
	if gameove = true then

	    exit
	end if
	var randquestion : int := Rand.Int (3, hardness) %check if level is completed or not completed
	if levelcompleted = 1 then
	    say ("Level " + intstr (currentlevel) + " completed.", 25, 20, 660)
	    for v : 1 .. 50
		staysay ("Level " + intstr (currentlevel) + " completed.", 25, 20, 660)
		delay (100)
	    end for
	    antisay ("Level " + intstr (currentlevel) + " completed.", 25, 20, 660)
	    moveship (currentx, currenty)
	    levelcompleted := 0
	    exit
	elsif levelcompleted = 2 then
	    say ("Level " + intstr (currentlevel) + " failed.", 25, 20, 660)
	    say ("Correct Answer: " + questions (subject, question, 2), 25, 20, 630)
	    for v : 1 .. 50
		staysay ("Level " + intstr (currentlevel) + " failed.", 25, 20, 660)
		staysay ("Correct Answer: " + questions (subject, question, 2), 25, 20, 630)
		delay (100)
	    end for
	    antisay ("Level " + intstr (currentlevel) + " failed.", 25, 20, 660)
	    antisay ("Correct Answer: " + questions (subject, question, 2), 25, 20, 630)
	    moveship (currentx, currenty)
	    levelcompleted := 0
	    exit
	else
	    if i = randanswer then
		fork createenemy (Rand.Int (30, maxx - 70), questions (subject, question, 2), true)
	    else
		fork createenemy (Rand.Int (30, maxx - 70), questions (subject, question, randquestion), false)
	    end if
	    delay (Rand.Int (100, 2000))
	end if
    end for

end givequestion

Music.PlayFileStop
Music.PlayFileLoop ("BEAT 1.mp3") %create music 1

loop
    if gameove = false then
	var subject : int := Rand.Int (1, 2)
	if subject = 1 then
	    givequestion (1, Rand.Int (1, 20))
	elsif subject = 2 then
	    givequestion (2, Rand.Int (1, 20))
	end if
	if currentlevel = 5 then
	    Music.PlayFileStop
	    say ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700) %give message if past level 5
	    say ("Congratz", 30, 20, 670)

	    for i : 1 .. 30
		staysay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
		staysay ("Congratz", 30, 20, 670)
		delay (100)
	    end for
	    antisay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
	    antisay ("Congratz", 30, 20, 670)


	    Music.PlayFileLoop ("BEAT 2.mp3") %create music 2

	    enemyspeed := enemyspeed + 1
	elsif currentlevel = 10 then
	    Music.PlayFileStop
	    say ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700) %give message if past level 10
	    say ("Nice job", 30, 20, 670)

	    for i : 1 .. 30
		staysay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
		staysay ("Nice job", 30, 20, 670)
		delay (100)
	    end for
	    antisay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
	    antisay ("Nice job", 30, 20, 670)

	    Music.PlayFileLoop ("BEAT 3.mp3") %create music 3
	    enemyspeed := enemyspeed + 2
	elsif currentlevel = 15 then
	    Music.PlayFileStop
	    say ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700) %give message if past level 15
	    say ("Good Luck", 30, 20, 670)

	    for i : 1 .. 30
		staysay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
		staysay ("Good Luck", 30, 20, 670)
		delay (100)
	    end for
	    antisay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
	    antisay ("Good Luck", 30, 20, 670)

	    Music.PlayFileLoop ("BEAT 4.mp3") %create music 4
	    enemyspeed := enemyspeed + 3
	elsif currentlevel = 20 then
	    Music.PlayFileStop
	    say ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
	    say ("You win!!!", 30, 20, 670)

	    for i : 1 .. 30
		staysay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700) %Give message if past level 20
		staysay ("You win!!!", 30, 20, 670)
		delay (100)
	    end for
	    antisay ("You've beaten " + intstr (currentlevel) + " levels", 30, 20, 700)
	    antisay ("You win!!!", 30, 20, 670)
	    gameove := true
	    fork gameover
	    exit
	end if
    end if
end loop
