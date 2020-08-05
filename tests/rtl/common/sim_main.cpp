#include <verilated.h>
#include "Vcore_wrapper.h"
#include "testbench.h"


int main(int argc, char** argv, char** env) {
    TESTBENCH<Vcore_wrapper> *tb;
    Verilated::commandArgs(argc, argv);
    tb = new TESTBENCH<Vcore_wrapper>();
    tb->opentrace("logs/trace.vcd");

    int result = 0;

    tb->load_program((char*) "main.hex", 0x0);

    for(int i = 0; i < 1000; i++){
        tb->tick();
    }

    // The test result+1 is written into the magic address
    // in order to prevent reading a success if the memory was 
    // uninitialized (e.g. remains 0)
    result = tb->read_mem(0x7ff0) - 1;

    // Cleanup
    tb->tick();
    tb->m_core->final();

    // Evaluate test
    if(result == 0)
        std::cout << "PASSED" << std::endl;
    else
        std::cout << "FAILED " << result << std::endl;
    
    //  Coverage analysis (since test passed)
    VerilatedCov::write("logs/coverage.dat");

    // Destroy model
    delete tb->m_core; tb->m_core = NULL;

    exit(0);
}
