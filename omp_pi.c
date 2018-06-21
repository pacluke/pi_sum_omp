#include <stdio.h>
#include <sys/time.h>
#include <stdio.h>
#include <omp.h>

double calcula_pi (long num_steps)
{
    long long i; 
    double x, pi, sum = 0.0;
    double step = 1.0/(double) num_steps;
    #pragma omp parallel for reduction(+:sum) private(i, x) firstprivate(step) 
    for (i = 0; i < num_steps; i++){
      x = (i+0.5)*step;
      double aux = 4.0/(1.0+x*x);
      sum += aux;
    }
    pi = step * sum;
    return pi;
}

double gettime (void)
{
  struct timeval tr;
  gettimeofday(&tr, NULL);
  return (double)tr.tv_sec+(double)tr.tv_usec/1000000;
}

int main (int argc, char **argv)
{
  long long num_steps = 1000000000000;
  double t0 = gettime();
  double pi = calcula_pi(num_steps);
  double t1 = gettime();
  printf("%.20f em %f segundos\n", pi, t1-t0);
}
