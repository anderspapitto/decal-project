#!/bin/bash

echo "enter command:"

while read command
do
    echo "enter command:"
    for i in ${#args[@]}; do args[$i]=''; done  #initialize args array
    i=0; cmd=$command;
    while [ "$cmd" ]       #parse command line args into args array
    do sed=`echo $cmd | sed 's/^\([^ "'\'']\+\) *\(.*$\)/\1@\2/
    s/^"\([^"]*\)" *\(.*\)$/\1@\2/
		    s/^'\''\([^'\'']*\)'\'' *\(.*\)$/\1@\2/'`
	args[$i]=`echo $sed | cut -f1 -d@`
	cmd=`echo $sed | cut -f2- -d@`
	i=$((i+1));  done
    case $command in
	calc )
	    echo "What operation do you want to use?"
	    while read operation
	    do
		case $operation in
		    add )
			echo "Please input 2 numbers you want to add."
			read numbers
			STR1=`echo $numbers | cut -d ' ' -f 1`
			STR2=`echo $numbers | cut -d ' ' -f 2`
			TOTAL=$(($STR1+$STR2))
			echo $TOTAL
			;;
		    mult )
			echo "Please input the 2 numbers you want to multiply."
			read numbers
			STR1=`echo $numbers | cut -d ' ' -f 1`
			STR2=`echo $numbers | cut -d ' ' -f 2`
			TOTAL=$(($STR1*$STR2))
			echo $TOTAL
			;;
		    sub )
			echo "Please input the 2 numbers you want to subtract."
			read numbers
			STR1=`echo $numbers | cut -d ' ' -f 1`
			STR2=`echo $numbers | cut -d ' ' -f 2`
			TOTAL=$(($STR1-$STR2))
			echo $TOTAL
			;;
		    divide )
			echo "Please input the 2 numbers you want to divide."
			read numbers
			STR1=`echo $numbers | cut -d ' ' -f 1`
			STR2=`echo $numbers | cut -d ' ' -f 2`
			TOTAL=$(($STR1/$STR2))
			echo $TOTAL
			;;
		    exp )
			echo "Please input the base, and then the exponent."
			read numbers
			STR1=`echo $numbers | cut -d ' ' -f 1`
			STR2=`echo $numbers | cut -d ' ' -f 2`
			TOTAL=`echo "$STR1 ^ $STR2" | bc`
			echo $TOTAL
			;;
		    exit )
			break
			;;
		    *)
			echo "Unrecognized Operation. Type exit to exit the calculator, or choose add, mult, sub, divide, or exp"
			;;
		esac
		echo "What operation do you want to use? Type add, mult, sub, divide, exp, or exit to exit the calculator"
	    done
	    ;;
	serverip )
	    echo "This server's IP address is `curl ifconfig.me`. Write it down!"
	    ;;
	diskspace )
	    echo "here is the server's current disk space information: "
	    df
	    ;;
	tcp )
	    echo "the server's current active port connections are: "
	    netstat -a | less
	    ;;
	featurerequest* )
	    i=1;
            while [ "${args[i]}" ]; do
		echo ${args[i]}
		echo ${args[i]} >> ./requestlog
		i=$((i+1))
	    done
	    echo requests logged
	    ;;

	greet* )
	    name=${args[1]}
	    mood=${args[2]}
	    if [ $mood = "happily" ]; then
		echo "Hi, $name! It's good to see you on this fine
    evening."
	    elif [ $mood = "angrily" ]; then
		echo "I hate you, $name, get the fuck out!"
	    elif [ $mood = "sadly" ]; then
		echo "Well hello, $name. I suppose it's nice to see you."
	    elif [ $mood = "frantically" ]; then
		echo "shit shit shit. This project is due in like an hour.
			Can you help me, $name?"
	    elif [ $mood = "absentmindedly" ]; then
		echo "Hello Wallace."
	    else
		echo huh?
	    fi
	    ;;
	play ) 
	    echo "If we had been able to implement this, you would be listening to music right now."
	    ;;
	usage )
	    echo "you can enter any of the commands
    calc
    serverip
    tcp
    diskspace
    featurerequest [features]
    greet [name] [mood=happily, angrily, sadly, frantically, absentmindedly]
    play
    exit"
	    ;;
	exit)
	    break
	    ;;
	*)
	    echo "that command is not implemented/we won't let you hack our system. Type usage for options."
	    ;;	
    esac
done
