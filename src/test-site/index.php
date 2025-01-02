<?php

// phpinfo();
xdebug_info();

function myRecurringFunction()
{
    // Your code here
    echo 'Function called at ' . date('Y-m-d H:i:s') . '<br />';
}

// Number of times to call the function
$timesToCall = 5;

// Interval in seconds
$interval = 5;

for ($i = 0; $i < $timesToCall; $i++) {
    myRecurringFunction();
    // Sleep for the specified interval
    sleep($interval);
}
