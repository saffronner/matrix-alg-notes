#show: set image(width: 50%);
// - $arrow(v)$
#set math.vec(delim: "[")
#set math.mat(delim: "[")
// #set text(font: "Garamond-Math.otf")
= Linalg
== lec 1 2024/08/26
- scalars: real numbers and stuff, $RR$

- vectors: a list of scalars. 

  - we use column vectors: $vec(1,pi) in RR^2$, etc

  - geometric picture: $RR^2$ is cartesian plane, $RR^3$ is 3d space, etc

- operations:

  - scalar multiplication: $2 dot vec(1,pi) = vec(2, 2pi)$. geometrically: "stretching/shrinking"

  - vector addition: $vec(1, pi) + vec(2, -pi) = vec(3, 0)$. geometrically: "tail to tip"

- standard vectors (think $hat(i), hat(j), hat(k)$ from 3dcalc)
  - $RR^2$: 
    - $ arrow(e_1) = vec(1, 0) $
    - $ arrow(e_2) = vec(0, 1) $
  - $RR^3$
    - $ arrow(e_1) = vec(1, 0, 0) $
    - $ arrow(e_2) = vec(0, 1, 0) $
    - $ arrow(e_3) = vec(0, 0, 1) $

- BIG POINT: every vec in $RR^n$ is a linear combination of standard vectors
  - ie, $vec(1,pi) = vec(1,0) + vec(0, pi) = vec(1,0) + pi vec(0, 1)$

- future language: $arrow(e)_1, arrow(e)_2, dots, arrow(e)_n$ _span_ $RR^n$

- matrices: an array of scalars:
  $ mat(1,0,7; 0,pi,1/2) $
  - variables to use: $A,B,C,U,V$
  $ A = mat(a_11, a_12, dots, a_(1n);
  a_21,a_22,dots,;
  dots.v,dots.v,,;
  a_(m 1)) $
  
  - $A_(i*)$ means the $i$th row1

== lec 2 2024/08/28
i deleted the whole lecture sob

- one method to matrix multiply:

  $mat(3,0,7; 0,pi,2) mat(2;0;-3) = 2mat(3;0) + 0mat(0;pi) + (-3)mat(7;2) = mat(-15; -6)$

  TODO what is the visual graphical intuition for what this means?
- but notice the dot producting going on. ie $(A B)_(i j) = A^T_(i*) dot B_(*j)$:
#figure(
  image("media/multiply_matrices.gif"),
  caption: "matrix multiplication. use dot products. see gif."
)
- matrix-vector mult is just viewing vector as column vector, 1 wide matrix
- matrix mult properties:
  - $m$x$n$ matrix times $n$x$o$ matrix is a $m$x$o$ matrix
  - Associative property for matrices: $A(B C)=(A B)C$
  - Commutative property of scalars: $c(A B)=(c A)B=A(c B)$
  - Left distributive property: $A(B+C)=A B+A C$
  - Right distributive property: $(B+C)A=B A+C A$
- transpose matrix ($A^T$): just leetcode flip 2d array
- $arrow(x) dot arrow(y) = arrow(x)^T arrow(y)$ when you view right half as matrix mult. as scalar
- TODO something about why $(A B)^T =  B^T A^T$?

== lec 3 2024/08/30
collapsed into lec2