    .data

numbers:
     .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9  # int numbers[10] = {0,1,2,3,4,5,6,7,8,9};

    .text

# t0 is i
# t1 is i*4
# t2 is x or numbers[i]
# t3 is (9-i)*4
# t4 is y or numbers[9-i]

main:
main__i_init:
     li   $t0, 0              # i = 0;

main__i_cond:
     bge  $t0, 5, main__i_end # # if (i >= 5) goto main__i_end;
     
main__i_body:
     mul  $t1, $t0, 4         # i * sizeof(int)
     lw   $t2, numbers($t1)   # int x = numbers[i];
     
     li   $t3, 9 
     sub  $t3, $t3, $t0       # 9 - i
     mul  $t3, $t3, 4         # (9 - i) * sizeof(int)
     lw   $t4, numbers($t3)   # int y = numbers[9 - i];
     
     sw   $t4, numbers($t1)   # numbers[i] = y;
     sw   $t2, numbers($t3)   # numbers[9 - i] = x;

main__i_step:
     addi      $t0, $t0, 1         # i++;
     
     j    main__i_cond

main__i_end:
     li   $v0, 0              #
     jr   $ra            # return 0
