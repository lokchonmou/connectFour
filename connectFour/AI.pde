void autoPlay(){
    long bestScore = 9223000000000000000L;
    int nextStep = 999;

    availableColume.clear();
    for (int j = 0; j < 7; j++){
        if (spot[0][j] == 0) availableColume.append(j);
    }
    availableColume.shuffle();

    long[] tempScore = new long[7];
    for (int j = 0; j < availableColume.size(); j++){
        int[][] tempSpot = new int[6][7];
        for (int i = 0; i < 6; i++)
        arrayCopy(spot[i], tempSpot[i]);

        //pick a step and simulate it
        for (int i = 0; i <= 5; i++){
            if (tempSpot[5-i][availableColume.get(j)] == 0) {
                tempSpot[5-i][availableColume.get(j)] = currentPlayer?-1:1;
                break;
            }
        }


        // int score = miniMax(tempSpot, currentPlayer, depth);
        long score = weightScale(tempSpot, currentPlayer, depth);
        tempScore[availableColume.get(j)] = score;
        if (score <= bestScore) {
            bestScore = score;
            nextStep = availableColume.get(j);
        }



    }
    for (int i = 0; i < tempScore.length; i++) print(tempScore[i], ' ');
    println("bestScore", bestScore);
    animation = true;
    currentColume = nextStep;
    currentRow = -1;
}
/*
long miniMax(int[][] _spot, boolean _currentPlayer, int deep){
    //println(deep);

    if (deep == 0) return 0;

    int[][] tempSpot = new int[6][7];
    for (int i = 0; i < 6; i++) arrayCopy(_spot[i], tempSpot[i]);


    int result = checkWin(tempSpot, false);

    // print the result that may win , for debug========
    
    if (result != 2){
        if (result ==  1) println("RED will win");
        if (result == -1) println("YELLOW will win");
        if (result ==  0) println("Will draw");
        for (int y = 0; y < 6; y++){
            for (int x = 0; x < 7; x++){
                print(tempSpot[y][x], '\t');
            }
            println();
        }
    }

    //===================================================

    if (result != 2) return matchScore(result);

    IntList _availableColume = new IntList();

    if (!_currentPlayer){   //YELLOW

        int _bestScore = 999 ;

        for (int j = 0; j < 7; j++){
            if (tempSpot[0][j] == 0) _availableColume.append(j);
        }
        _availableColume.shuffle();

        for (int j = 0; j < _availableColume.size(); j++){
            //pick a step and simulate it
            for (int i = 0; i <= 5; i++){
                if (tempSpot[5-i][_availableColume.get(j)] == 0) {
                    tempSpot[5-i][_availableColume.get(j)] = _currentPlayer?1:-1;
                    break;
                }
            }

            long score = miniMax(tempSpot, true, deep - 1);

            for (int i = 0; i < 6; i++) arrayCopy(_spot[i], tempSpot[i]);

            _bestScore = min(_bestScore, score);


        }
        return  _bestScore;
    }
    else{      //RED

        int _bestScore = -999 ;

        for (int j = 0; j < 7; j++){
            if (tempSpot[0][j] == 0) _availableColume.append(j);
        }
        _availableColume.shuffle();

        for (int j = 0; j < _availableColume.size(); j++){
            //pick a step and simulate it
            for (int i = 0; i <= 5; i++){
                if (tempSpot[5-i][_availableColume.get(j)] == 0) {
                    tempSpot[5-i][_availableColume.get(j)] = _currentPlayer?1:-1;
                    break;
                }
            }

            int score = miniMax(tempSpot, false, deep -1);

            for (int i = 0; i < 6; i++) arrayCopy(_spot[i], tempSpot[i]);

            _bestScore = max(_bestScore, score);

        }
        return _bestScore;
    }

}
*/

long weightScale(int[][] _spot, boolean _currentPlayer, int deep){
    //println(deep);

    if (deep == 0) return 0;

    int[][] tempSpot = new int[6][7];
    for (int i = 0; i < 6; i++) arrayCopy(_spot[i], tempSpot[i]);


    int result = checkWin(tempSpot, false);

    // print the result that may win , for debug========
    /*
    if (result != 2){
        if (result ==  1) println("RED will win");
        if (result == -1) println("YELLOW will win");
        if (result ==  0) println("Will draw");
        for (int y = 0; y < 6; y++){
            for (int x = 0; x < 7; x++){
                print(tempSpot[y][x], '\t');
            }
            println();
        }
    }
    */
    //===================================================

    if (result != 2) return (int)pow(10,deep) * matchScore(result);

    IntList _availableColume = new IntList();

    if (!_currentPlayer){   //YELLOW

        int _bestScore = 0 ;

        for (int j = 0; j < 7; j++){
            if (tempSpot[0][j] == 0) _availableColume.append(j);
        }
        _availableColume.shuffle();

        for (int j = 0; j < _availableColume.size(); j++){
            //pick a step and simulate it
            for (int i = 0; i <= 5; i++){
                if (tempSpot[5-i][_availableColume.get(j)] == 0) {
                    tempSpot[5-i][_availableColume.get(j)] = _currentPlayer?1:-1;
                    break;
                }
            }

            long score = weightScale(tempSpot, true, deep - 1);

            for (int i = 0; i < 6; i++) arrayCopy(_spot[i], tempSpot[i]);

            _bestScore += score;


        }
        return  _bestScore;
    }
    else{      //RED

        int _bestScore = 0 ;

        for (int j = 0; j < 7; j++){
            if (tempSpot[0][j] == 0) _availableColume.append(j);
        }
        _availableColume.shuffle();

        for (int j = 0; j < _availableColume.size(); j++){
            //pick a step and simulate it
            for (int i = 0; i <= 5; i++){
                if (tempSpot[5-i][_availableColume.get(j)] == 0) {
                    tempSpot[5-i][_availableColume.get(j)] = _currentPlayer?1:-1;
                    break;
                }
            }

            long score = weightScale(tempSpot, false, deep -1);

            for (int i = 0; i < 6; i++) arrayCopy(_spot[i], tempSpot[i]);

            _bestScore += score;

        }
        return _bestScore;
    }

}


int matchScore(int input){
    if (input == -1)      return -10;
    if (input == +1)      return +10;
    if (input ==  0)      return   0;
    if (input ==  2)      return   0;

    return 0;
}
