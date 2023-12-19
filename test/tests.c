#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <CUnit/Basic.h>

#include "../include/temp.h"


// #define return clear_stack(stack); return
//Last suite to use get log to stay
int init_suite(void)
{ 
    return 0;
    // END_SCOPE //} while(0)
}

int clean_suite(void)
{
    return 0;
}

void test_template_test()
{
    int toCompare = 5;
    store(toCompare);
    CU_ASSERT_EQUAL(fetch(), toCompare);
}
//Or we can to a test with initalize that calls
//obj *ptr = calloc(1, obj)
//
int main()
{
    CU_pSuite template_suite = NULL;

    if (CUE_SUCCESS != CU_initialize_registry()) {
        return CU_get_error();
    }

    template_suite = CU_add_suite("temp", init_suite, clean_suite);
    if (NULL == template_suite) {
    CU_cleanup_registry();
    return CU_get_error();
    }

    if ((NULL == CU_add_test(template_suite, "Running template, Remove me", test_template_test)))
    {
    CU_cleanup_registry();
    return CU_get_error();
    }

    CU_basic_set_mode(CU_BRM_VERBOSE);
    CU_basic_run_tests();
    return CU_get_error();
}
