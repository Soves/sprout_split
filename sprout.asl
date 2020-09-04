
state("-SPROUT_V1-"){
    double time : 0x008372E0, 0x2C, 0x10, 0x438, 0x1F0;
    string255 gameEvent : 0x008372E0, 0x2C, 0x10, 0x528, 0x10, 0x0, 0x0;
}
/*
state("-SPROUT- THE BETA"){
    double time : 0x0075DBB0, 0x2C, 0x10, 0xA8, 0x230;
    string255 gameEvent : 0x0075DC28, 0x2C, 0x10, 0x684, 0x0, 0x0, 0x0;
}*/

init {
    //init variables
    vars.totalTime = 0;
    vars.split = false;
    vars.paused = false;
    print("!!!INIT!!!");
}

start{
    //start run
    if (current.gameEvent.Contains("started") && current.time >= 100){
        vars.split = true;
        vars.totalTime = 0;
        return true;
    }
}

gameTime{
    
    //pass in level time added with sum of completed levels time
    if (!vars.paused){
        if (current.time < 100){
            return TimeSpan.FromMilliseconds(vars.totalTime);
        }else{
            return TimeSpan.FromMilliseconds(vars.totalTime+current.time);
        }
    }
}

update {
    //make sure game unpauses when area starts
    if (current.gameEvent.Contains("started")){
        vars.paused = false;
        vars.split = false;
    }
    
}

isLoading{
    return vars.paused || current.time < 100;
}

reset {
    
    //reset run
    if (current.gameEvent.Contains("quit")){
        vars.paused = false;
        return true;
    }
    
}

split {
    
    //split if area finish is triggered
    if (current.gameEvent.Contains("finished") && vars.split == false){
        vars.totalTime = vars.totalTime+old.time;
        vars.split = true;
        vars.paused = true;
        return true;
    }
}