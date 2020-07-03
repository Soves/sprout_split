
state("-SPROUT- THE BETA"){
    double time : 0x0075DBB0, 0x2C, 0x10, 0xA8, 0x230;
    string255 gameEvent : 0x0075DC28, 0x2C, 0x10, 0x684, 0x0, 0x0, 0x0;
}

init {
    vars.totalTime = 0;
    vars.split = false;
    vars.paused = false;
    print("!!!INIT!!!");
}

start{
    if (current.gameEvent == "-THE GROVE- started"){
        vars.split = true;
        vars.totalTime = 0;
        return true;
    }
}

gameTime{
    if (!vars.paused){3
        return TimeSpan.FromMilliseconds(vars.totalTime+current.time);
    }
}

update {
    if (current.gameEvent.Contains("started")){
        vars.paused = false;
        vars.split = false;
    }
}

isLoading{
    return vars.paused;
}

reset {
    if (current.gameEvent.Contains("quit")){
        vars.paused = false;
        return true;
    }
}

split {
    
    if (current.gameEvent.Contains("finished") && vars.split == false){
        vars.totalTime = vars.totalTime+old.time;
        vars.split = true;
        vars.paused = true;
        return true;
    }
}