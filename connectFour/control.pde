void mousePressed(){
    if (animation == false){
        for (int j = 0; j < 7; j++){
            if (mouseX > width/7*j && mouseX <= width/7*(j+1)) {
                animation = true;
                currentColume = j;
                currentRow = -1;
            }
        }
    }
}

void keyPressed(){
    if (key == 'P' || key == 'p'){
        for (int i = 0; i < 6; i++){
            for (int j = 0; j < 7; j++){
                print(spot[i][j], '\t');
            }
            println();
        }
        println("currentColume" , currentColume);
        println("currentPlayer", currentPlayer);
        println("animation", animation);
        println("GAMEOVER", GAMEOVER);
    }
    if (key == 'R' || key == 'r')   setup();
}
