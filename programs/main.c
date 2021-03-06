#include <stdio.h>
#include <graphics.h>
#include <math.h>

void disp(float v[][3])
{
  float xmax, ymax;
  xmax = getmaxx() / 2;
  ymax = getmaxy() / 2;

  int i = 0;
  while (i < 2)
  {
    line(xmax + v[i][0], ymax - v[i][1], xmax + v[i + 1][0], ymax - v[i + 1][1]);
    i++;
  }
  i = 2;

  line(xmax + v[i][0], ymax - v[i][1], xmax + v[0][0], ymax - v[0][1]);

  setcolor(RED);
  line(0, ymax, xmax * 2, ymax); // horizontal x – axis ;
  line(xmax, 0, xmax, ymax * 2); // vertical y – axis
  setcolor(WHITE);
}

void multiply(float b[][3], float v[][3], float a[][3])
{
  int i, j, k;

  for (i = 0; i < 3; i++)
    for (j = 0; j < 3; j++)
      a[i][j] = 0;

  for (i = 0; i < 3; i++)
    for (j = 0; j < 3; j++)
      for (k = 0; k < 3; k++)
      {
        a[i][j] = a[i][j] + (v[i][k] * b[k][j]);
      }
}

void reflect(float v[][3])
{
  float b[10][3], a[10][3];
  int i = 0, j;

  // clrscr();
  cleardevice();
  disp(v);

  for (i = 0; i < 3; i++)
    for (j = 0; j < 3; j++)
    {
      b[i][j] = 0;
      if (i == j)
        b[i][j] = 1;
    }

  b[1][1] = -1; //About X-axis ;
  multiply(b, v, a);
  setcolor(YELLOW);
  disp(a);
}

int main()
{
  freopen("input.txt", "r", stdin);
  freopen("output.txt", "w", stdout);

  int gd = DETECT, gm;
  float v[10][3];

  printf(" Enter the vertex coordinate of triangle:\n");
  for (int i = 0; i < 3; i++)
  {
    printf("Enter the coordinate v % d:\n", i + 1);
    scanf("%f", &v[i][0]);
    scanf("%f", &v[i][1]);

    v[i][2] = 1;
  }
  initgraph(&gd, &gm, NULL); //you can give path on your own

  // clrscr();
  cleardevice();
  setcolor(BLACK);
  disp(v);
  reflect(v);
  getch();
  delay(7000);
  closegraph();
}
