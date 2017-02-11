program test_random

    use random_mod

    implicit none

    print*, "test_normal_to_cdf_conversion"
    call test_normal_to_cdf_conversion()


contains


    subroutine test_normal_to_cdf_conversion()

        implicit none
        integer, parameter :: ntest_values = 23

        ! hard coded expected CDF values for given normal value from scipy.stats.norm.cdf
        real :: normal_values(ntest_values) = [-5.50, -5.00, -4.50, -4.00, -3.50, -3.00, -2.50, -2.00, &
                                               -1.50, -1.00, -0.50, 0.000, 0.500,  1.00,  1.50,  2.00, &
                                                2.50,  3.00,  3.50,  4.00,  4.50,  5.00,  5.50]

        real :: cdf_values(ntest_values) = [0.000000019, 0.0000002, 0.0000033, 0.0000316, 0.0002326, &
                                              0.0013498, 0.0062096, 0.0227501, 0.0668072, 0.1586552, &
                                              0.3085375, 0.5000000, 0.6914624, 0.8413447, 0.9331927, &
                                              0.9772498, 0.9937903, 0.9986501, 0.9997673, 0.9999683, &
                                              0.9999966, 0.9999997, 0.9999999810]
        logical :: passing
        integer :: i

        passing = .True.

        ! iterate over all values to test, if expected value is more than 2e-3 away from the actual result it fails
        do i = 1, ntest_values
            if (abs(cdf_values(i) - normal_cdf( normal_values(i) ) ) > 2e-3) then
                passing = .False.
                print*, ""
                print*, " Error = ",cdf_values(i) - normal_cdf( normal_values(i))
                print*, " Expected = ", cdf_values(i)
                print*, " Got: ",normal_cdf( normal_values(i)), " for:",normal_values(i)
            endif
        end do

        if (passing) then
            print*, " PASSED"
        else
            print*, " FAILED"
        endif
    end subroutine test_normal_to_cdf_conversion


end program test_random
