#HUGHPAGES
echo 128| sudo tee /proc/sys/vm/nr_hugepages
sudo sysctl -w vm.nr_hugepages=128

#PREREQ
sudo add-apt-repository -y ppa:jonathonf/gcc-7.1
sudo apt update
sudo apt install -y libmicrohttpd-dev libuv1-dev cmake cmake-extras gcc-7 g++-7

#BUILD
cd
git clone https://github.com/webchain-network/webchain-miner.git
cd webchain-miner/
mkdir build
cd build
cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7
make

#CONFIG
cat << EOF | sudo tee config.json >/dev/null
{                                                                                                            
    "algo": "cryptonight-webchain",
    "av": 0,                // algorithm variation, 0 auto select                                            
    "background": false,    // true to run the miner in the background                                       
    "colors": true,         // false to disable colored output                                               
    "cpu-affinity": "0xF",   // set process affinity to CPU core(s), mask "0x3" for cores 0 and 1             
    "cpu-priority": 2,   // set process priority (0 idle, 2 normal to 5 highest)                          
    "donate-level": 1,      // donate level, mininum 1%                                                      
    "log-file": null,       // log all output to a file, example: "c:/some/path/webchain-miner.log"          
    "max-cpu-usage": 83,    // maximum CPU usage for automatic mode, usually limiting factor is CPU cache not this option.                                                                                                 
    "print-time": 60,       // print hashrate report every N seconds                                         
    "retries": 5,           // number of times to retry before switch to backup server                       
    "retry-pause": 5,       // time to pause between retries                                                 
    "safe": false,          // true to safe adjust threads and av settings for current CPU                   
    "syslog": false,        // use system log for output messages                                            
    "threads": null,        // number of miner threads                                                          
    "pools": [
        {
            "url": "pool.webchain.network:3333", // URL of mining server
            "user": "0x3d01610594788e2a639c995deaafa230c0200a53",               // username for mining server
            "pass": "x",                         // password for mining server
            "worker-id": "$HOSTNAME",                    // worker ID for mining server
            "keepalive": false,                  // send keepalived for prevent timeout (need pool support)
            "nicehash": false
        }
    ],
    "api": {
        "port": 0,                             // port for the miner API https://github.com/xmrig/xmrig/wiki/API
        "access-token": null,                  // access token for API
        "worker-id": null                      // custom worker-id for API
    }
}
EOF

geany config.json 2>/dev/null

#HINT
echo -e start miner with: $PWD/webchain-miner
