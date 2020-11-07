int spot[][] = new int[6][7];
int circleSize = 80;

boolean currentPlayer ;
boolean animation;
int currentColume, currentRow;
boolean GAMEOVER;

//for AI==============
IntList availableColume;
int depth = 4;
//====================

void setup() {
    size(700,600);
    pixelDensity(displayDensity());
    ellipseMode(CENTER);
    frameRate(10);

    currentPlayer = false;
    //false = RED, true = YELLOW
    animation = false;
    currentColume = 0;
    currentRow = -1;
    GAMEOVER = false;
    for (int i = 0; i < 6; i++)
    for (int j = 0; j < 7; j++)
    spot[i][j] = 0;
    availableColume = new IntList();
}

void draw(){
    if (!GAMEOVER){
        display();
    }

}

void display(){

    fillBackground(matchColor(currentPlayer?-1:1));
    fillAllEllipse();

    if (animation){
        // fill the currunt colume and add one row
        if (spot[currentRow+1][currentColume] == 0) {
            fill(matchColor(currentPlayer?-1:1));
            fillOneEllipse(currentRow, currentColume);
            if (currentRow <= 4) currentRow++;
        }
        // 當棋子到底或者到達之前已填的格之上
        if (currentRow == 5 || spot[currentRow+1][currentColume] != 0 && currentRow != -1){
            spot[currentRow][currentColume] = currentPlayer?-1:1;
            currentRow = -1;
            if (checkWin(spot, true) != 2) GAMEOVER = true;
            else currentPlayer = !currentPlayer;

            animation = false;

            //for AI==============
            if (currentPlayer) autoPlay();
            //====================
        }
        //check if the colume is full
        if (spot[0][currentColume] != 0 && currentRow == -1)
        animation = false;
    }

}

int checkWin(int[][] _spot, boolean highLightWinEllipse){
    int[][] tempSpot = new int[6][7];
    for (int i = 0; i < 6; i++)
        arrayCopy(_spot[i], tempSpot[i]);

    for (int y = 0; y < 6; y++){
        for (int x = 0; x < 7; x++){
            if (x >= 3) {   //left 4
                int winner = highLightWinEllipse?fillWinEllipse(x, y, -1, 0):checkFourConnect(tempSpot, x, y, -1, 0);
                if (winner != 2) return winner;
            }
            if (y >= 3){     //up 4
                int winner = highLightWinEllipse?fillWinEllipse(x, y, 0, -1):checkFourConnect(tempSpot, x, y, 0, -1);
                if (winner != 2) return winner;
            }
            if (y >=3 && x >= 3){   //left up 4
                int winner = highLightWinEllipse?fillWinEllipse(x, y, -1, -1):checkFourConnect(tempSpot, x, y, -1, -1);
                if (winner != 2) return winner;
            }
            if (y <= 2 && x >= 3){   //left down 4
                int winner = highLightWinEllipse?fillWinEllipse(x, y, -1, +1):checkFourConnect(tempSpot, x, y, -1, +1);
                if (winner != 2) return winner;
            }
        }
    }

    // ties
    boolean allZero = true;
    for (int j = 0; j < 7; j++) allZero = allZero && tempSpot[0][j] != 0;
    if (allZero) return 0;

    //no result
    return 2;
}


color matchColor(int type){
    if (type == 0) return color(255);
    else if (type == 1) return color(255,86,65);
    else if (type == -1) return color(255,223,55);
    return 0;
}

void fillBackground(color turnColor){
    fill(80,119,199);
    stroke(turnColor);
    strokeWeight(15);
    rect(0, 0, width, height);
}

void fillAllEllipse(){
    stroke(0);
    strokeWeight(2);
    for (int k = 0; k < 6; k++){
        for (int j = 0; j < 7; j++){
            fill(matchColor(spot[k][j]));
            ellipse(width/7*(j+.5), height/6*(k+.5), circleSize,circleSize);
        }
    }
}

void fillOneEllipse(int x, int y){
    ellipse(width/7*(y+.5), height/6*(x+.5), circleSize,circleSize);
}

int checkFourConnect(int[][] _spot, int x, int y, int minusX, int minusY){
    int[][] tempSpot = new int[6][7];
    for (int i = 0; i < 6; i++)
        arrayCopy(_spot[i], tempSpot[i]);


    int sum = 0;
    for (int k=0; k <4; k++)    sum+= tempSpot[y + minusY*k][x + minusX*k];
    if (abs(sum) >= 4) return sum>0 ? 1: -1;
    return 2;
}

int fillWinEllipse(int x, int y, int minusX, int minusY){
    int sum = 0;
    for (int k=0; k <4; k++)    sum+= spot[y + minusY*k][x + minusX*k];
    if (abs(sum) >= 4) {
        fillBackground(matchColor(currentPlayer?-1:1));
        fillAllEllipse();

        strokeWeight(8);
        stroke(#FFFF00);
        fill(matchColor(sum>0 ? 1: -1));
        for (int k=0; k <4; k++)    fillOneEllipse(y + minusY*k, x + minusX*k);

        return sum>0 ? 1: -1;
    }
    return 2;
}
