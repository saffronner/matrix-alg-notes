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
=== Matrix Multiplication
- definition:
#figure(
  image("media/multiply_matrices.gif"),
  caption: "matrix multiplication. use dot products. see gif."
)
- matrix mult. can also be viewed row-wise and column-wise (#link("https://ghenshaw-work.medium.com/3-ways-to-understand-matrix-multiplication-fe8a007d7b26")[medium post link])
  - let $A B = C$
  - a col of $C$ is a linear combination of cols of $A$; weighted by the corresponding col of $B$
  - a row of $C$ is a linear combination of rows of $B$, weighted by the corresponding row of $A$
#image("media/matrix_mult_rowcol_forms.png")

- matrix-vector mult is just viewing vector as column vector, 1 wide matrix
- matrix mult properties:
  - $m$x$n$ matrix times $n$x$o$ matrix is a $m$x$o$ matrix
  - Associative property for matrices: $A(B C)=(A B)C$
  - Commutative property of scalars: $c(A B)=(c A)B=A(c B)$
  - Left distributive property: $A(B+C)=A B+A C$
  - Right distributive property: $(B+C)A=B A+C A$
  - Identity property: $I_m A = A = A I_n$
- transpose matrix ($A^T$): just leetcode flip 2d array
- $arrow(x) dot arrow(y) = arrow(x)^T arrow(y)$ when you view right half as matrix mult. as scalar
- TODO something about why $(A B)^T =  B^T A^T$?

== lec 3 2024/08/30
collapsed into lec2

== lec 2024/09/04
- special matrices
  - nxn: square
  - $I_n$: the nxn identity matrix
    - $A I = A$ and $I A = A$ for any $A$
  - permutation matrices: sudoku the 1s
    - $
      mat(0,1,0;0,0,1;1,0,0)mat(A_(1*);A_(2*);A_(3*)) = mat(A_(2*); A_(3*); A_(1*))
      $
  - diagonal matrices: entries not on diagonal are 0. usually square.
    - geometrically, the "scale our axes"
    - jacobian matrices :3
  - upper triangular: $A_(i j) = 0 "if" i > j$. i.e. entries _stictly_ lower than diag must be 0.
    - lower triangular: see above. 
    - swap between lower/upper triang. via transposes
    - used to solve systems of equations

=== systems of linear equations
- e.g. solve $A arrow(x) = arrow(b)$ where $A$ is a upper triang. matrix 
  $
  A = mat(1,-1,2;0,8,-2;0,0,3), arrow(b) = vec(3,4,6) $
- a linear equation is of the form $a_1x_1 + a_2x_2 + ... + a_n x_n = c$

== lec 2024/09/06
- review: solving systems in general

  get from system of equations matrix to eschelon form matrix to reduced eschelon form
  #image("media/solving_system_1.jpg")
  #image("media/solving_system_2.jpg")

- elementary row operations
  - all reversible
  - `row = c * row`
  - `row += c * other_row`
  - interchange rows

- two systems are equivalent (have same soln set) if their corresponding augmented matrices are rwo equivalent

- a linear system is _consistent_ if it has solutions (1 or inf) and _inconsistent_ otherwise (no solutions)
  - inconsistent class example: we did the solve path and got an eschelon form of
    $
    mat(2,-3,2,1; 0,1,-4,8;0,0,0,15)
    $
    but $0 != 15$.
  - consistent inf solutions class example: did solve path and got solution set of 
  $
  { arrow(x) = vec(x_1,x_2,x_3)=vec(1,4,0)+x_3 vec(5,-1,1) : x_3 in RR}
  $

- Echelon Form (EF) "easy to solve" definition:
  - all nonzero rows above zero rows
  - each leading entry (first nonzero entry) of a row is in a col to the right of the leading entry above 
  - all entries below leading entry are zero
  #image("media/echelon_form_visualization.jpg")

- solving "easy to solve" Echelon Form get Reduced EF (REF)
  - subset of Echelon form
  - all leading entries are 1s
  - each leading entry is the only nonzero in its column