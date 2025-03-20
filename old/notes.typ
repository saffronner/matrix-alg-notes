#show: set image(width: 50%);
// - $arrow(v)$
#set math.vec(delim: "[")
#set math.mat(delim: "[")
// #set text(font: "Garamond-Math.otf")
#let span = math.op("span")
#let col = math.op("col")

= Linalg
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
  - $RR^3$:
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
  
  - $A_(i*)$ means the $i$th row

== Matrix Multiplication
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

- special matrices
  - nxn: square
  - $I_n$: the nxn identity matrix
    - $A I = A$ and $I A = A$ for any $A$
  - permutation matrices: sudoku the 1s
    - $
      mat(0,1,0;0,0,1;1,0,0)mat(A_(1*);A_(2*);A_(3*)) = mat(A_(2*); A_(3*); A_(1*))
      $
  - diagonal matrices: entries not on diagonal are 0. usually square.
    - geometrically, they "scale our axes"
    - jacobian matrices :3
  - upper triangular: $A_(i j) = 0 "if" i > j$. i.e. entries _stictly_ lower than diag must be 0.
    - lower triangular: see above. 
    - swap between lower/upper triang. via transposes
    - used to solve systems of equations

== systems of linear equations
- e.g. solve $A arrow(x) = arrow(b)$ where $A$ is a upper triang. matrix 
  $
  A = mat(1,-1,2;0,8,-2;0,0,3), arrow(b) = vec(3,4,6) $
- a linear equation is of the form $a_1x_1 + a_2x_2 + ... + a_n x_n = c$

- review: solving systems in general

  get from system of equations matrix to echelon form matrix to reduced echelon form
  #image("media/solving_system_1.jpg")
  #image("media/solving_system_2.jpg")

- elementary row operations <elementary_row_operations>
  - elementary matrices $E$ correspond to these. 
    - use via $E A$. 
    - these are invertible
  - all reversible
  - scaling rows: `row *= c`
    #figure(
      $
      E = mat(1,0,0;0,1,0;0,0,3)
      $, 
      caption: [scale 3rd row by 3]
    )
  - replace rows: `row += c * other_row`
    #figure(
      $
      E = mat(1,0,0;0,1,0;3,0,1)
      $, 
      caption: [add 3R1 to 3rd row]
    )
  - interchange rows
    - permutation matrices: swap the rows of $I$ you want to swap

- two systems are equivalent (have same soln set) if their corresponding augmented matrices are rwo equivalent

- a linear system is _consistent_ if it has solutions (1 or inf) and _inconsistent_ otherwise (no solutions)
  - a system is consistent iff the rightmost column of the augmented matrix is _not_ a pivot column
  - if system consistent, then (inf. many solutions iff free variables exist)
  - inconsistent class example: we did the solve path and got an echelon form of
    $
    mat(2,-3,2,1; 0,1,-4,8;0,0,0,15; augment: #3)
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
  - unique
  - all leading entries are 1s
  - each leading entry is the only nonzero in its column
  #image("media/reduced_echelon_form_visualiztion.png")

- A pivot position corresponds to a leading 1 entry in the REF
- A pivot column is a column of A that contains a pivot position.

== Gaussian Elimination
- how we get to the reduced echelon form
- eg general solution to:
  $
  mat(1,-2,-1,3,0; -2,4,5,-5,3; 3,-6,-6,8,-3; augment: #4)
  $
  `R2 + 2R1,  R3 - 3R1,  R3 + R2,  R2 / 3,  R1 + R2`

- let non pivot columns be free variables

#figure(
  image("media/solving_system_full.png"),
  caption: "full example of solving a system"
)

- algorithm:
  - "forward phase" gets to EF
    + find leftmost nonzero column. (a pivot pos at top.) use row swaps to move a nonzero entry to pivot pos
    + use row replacement to get zeros below the pivot.
    + recurse: ignore top row, repeat prev. 2 steps on rest of matrix
  - "backward phase" get to REF
    4. use rescaling to make all leading entries 1
    5. working left/upward, zero entires above pivot positions

== Homogeneous Systems
- a linear system is _homogeneous_ iff it has the form $A arrow(x) = arrow(0)$
  - (non/in homogeneous if that 0 is a nonzero $arrow(b)$)
  - always consistent: $arrow(x) = arrow(0)$ is always a (trivial) solution

- but do they have nontrivial solutions?
  - just solve it (g. elim.)

- if a homogeneous and nonhomogeneous system differs only in their $arrow(0) "vs" arrow(b)$ vector, their solutions sets will only differ by a translation
  - eg you might get 
    $
    arrow(x)_"homogenous" = x_1 vec(1/5, 0, 1) "and" arrow(x)_"inhomogenous"= vec(0,8,-2) + x_1 vec(1/5, 0, 1)
    $
  - i.e., if $A arrow(x) = arrow(b)$ is consistent and $arrow(p)$  is a solution (i.e. $A arrow(p) = arrow(b)$), then the solution set to $A arrow(x)=arrow(b)$ is ${arrow(p) + arrow(v) : A arrow(v) = 0}$
    - (note that for $A arrow(x) = 0$, the soln set is ${arrow(x) : A arrow(x) = 0}$)

== Matrix inverses 
- valid for for square matrices

#figure(
  image("media/matrix_inverse_primer.png"),
  caption: [matrix inverses primer/motivating examples]
)

- a matrix $A$ is _invertible_ if there is a matrix $C$ s.t. $C A = I$ and $A C = I$
  - in this case, $C = A^(-1)$

- if $A,B$ invertible, then $A B$ invertible and $(A B)^(-1) = B^(-1) A^(-1)$
  - imagine $A B arrow(x)$ is B first acting on $arrow(x)$ then $A$ acting on that. to undo, "shoes then socks" stack data structure method, we first $A^(-1)$ to undo the $A$ and then likewise with $B$, getting $B^(-1) A^(-1)$ <TEMPTEMP>

- finding inverse not always possible. let $A = mat(1,1;1,1), $ trying to find $A^(-1).$
  $
  mat(1,1;1,1)mat(a,b;c,d)=mat(1,0;0,1) \
  = mat(a+c, b+d; a+c, b+d)
  $
  but $0 != 1$.

- non-invertible matrices are called _singular_

- if $A$ invertible, $A arrow(x) = arrow(b)$ has a unique solution $arrow(x) = A^(-1) arrow(b)$

- how to try finding $A^(-1)$
  - let $A = mat(a,b;c,d)$ and the determinant $D$ be $a d - b c$.
  - if $D != 0$, then $A^(-1) = 1/D mat(d,-b;-c,a)$
  - if $D = 0, A$ is singular

- in general for nxn matrices, find $A^(-1)$ via row reduction
  - form the matrix $mat(A,I, augment: #1)$ and put it in REF
  - if $A$ is invertible, we get $mat(I, A^(-1), augment: #1)$
  - if $A$ is not invertible, then REF of $A$ is not $I$
  #figure(
    image("media/finding_mat_inverse_ex.png"),
    caption: [finding matrix inverse example]
  )
  #figure(
    image("media/finding_mat_inverse_reasoningproof.png"),
    caption: [proof of why this method works]
  )

- elementary matrices are invertible (#link(<elementary_row_operations>)[noted above]). 
  #figure(
    image("media/inverting_elementary_matrices_ex.png"),
    caption: [inverting elementary matrices]
  )
  - so if REF of $A$ is $I$, there are $E_1, ..., E_m$ s.t. 
    $
    (E_m E_(m-1) ... E_2 E_1)A = I
    $
    thus, $A^(-1)$ is simply the product of the elementary matrices.

    additionally, $ A= E_1^(-1) ... E_(m-1)^(-1) E_m^(-1) $
    following from socks/shoes above (#link(<TEMPTEMP>)[link])

=== Vector spaces
- vector spaces: $RR^n$ 

- span: if $arrow(v)_1, ..., arrow(v)_n in RR^m$, their span is the set of all linear combinations
  - i.e. $span{arrow(v)_1, ..., arrow(v)_n} = {c_1 arrow(v)_1+ ...+ c_n arrow(v)_n : c_1, ..., c_n  in RR}$

- consider the question: determine if $arrow(b) in span{arrow(v)_1, ..., arrow(v)_n}$.
  - i.e., are there constants such that $c_1 arrow(v)_1 + ... + c_n arrow(v)_n = arrow(b)$.
  - if we view each $arrow(v)$ as  a column vector of a matrix $A$, we realize we are just asking: solve $A arrow(c) = arrow(b)$

- thus, view columns of a matrix as spanning some linear space (line, plane, hyperplane)
  - $A arrow(x) = arrow(b)$ is consistent iff $arrow(b) in span{"the cols of" A}$

- theorem:
  - the columns of $A$ span $RR^n$ ($n$ being "height" of $A$)
  - iff $forall arrow(b) in RR^n, A arrow(x) = arrow(b)$ is consistent
  - iff $A$ has a pivot pos in every row

- theorem:
  - the columns of $A$ are _linearly independent_
  - iff $A arrow(x) = 0$ has only one solution (the trivial $arrow(x) = arrow(0)$)
  - iff $A$ has a pivot pos in every column
  - (intuit: all vecs point in "different directions")
  - (the column vecs are otherwise _linearly dependent_)


- thrm: if $V = {arrow(v)_1, ..., arrow(v)_n}$ are linearly dependent, $exists arrow(v)_j in V, arrow(v)_j in span{V without arrow(v)_j}$
  - i.e., if vecs are linearly dependent, one is in the span of the others 

- thrm: if $arrow(v)_1, ..., arrow(v)_n in RR^m$ and $n > m$, then the vecs are linearly dependent.
  - informal proof: form the matrix $A$ from col vecs $arrow(v)$. $A$ is $n$ wide, $m$ tall. since $n > m$, this means there _must_ be some pivot column and therefore inf. solutions.

- let $B = {arrow(b)_1, ... arrow(b)_m}$. $B$ is a basis for $RR^m$ if $span{B} = RR^m$ and $B$ is linearly independent.
  - all bases of $RR^m$ have the same size (square! think: why? hints above...)

- more generally, let $B = {arrow(b)_1, ... arrow(b)_m}$. $B$ is a basis for a subspace $H$ if $span{B} = H$ and $B$ is linearly independent.
  - all bases of $H$ have the same size (not necessarily square), calle the dimension of $H$, $dim H$

- a subspace is denoted $H subset.eq RR^m$
  - properties: 
    + $0 in H$
    + if $arrow(u), arrow(v) in H$, then $arrow(u) +  arrow(v) in H$ 
    + if $arrow(u) in H, c in RR$, then $c arrow(u) in H$
  - eg plane through $RR^3$'s origin
  - non-eg a circle in $RR^2$. subspaces don't curve? if we escape the subspace by taking two points and adding them it's not actually a subspace.

- subspaces are spans of vectors ($H = span{arrow(v)_1, ..., arrow(v)_k}$)

- "spanning set theorem": 
  - let $S = {arrow(v)_1, ..., arrow(v)_k}, H = span S$.

    if $S$ is linearly dependent ($exists$ redundancy), then $exists arrow(v)_j in S, arrow(v)_j in span{S without arrow(v)_j}$
  - (this is basically a duplicate of above)
  - note that $span{S} = span{S without arrow(v)_j}$
  - can keep on "removing" vectors. when you are independent, you get $B$, a basis for $H$

- let the column space of a matrix, $col(A)$, be the span of the columns of a matrix $A$
  - notice: this is a subspace!

- find a basis for $col(A)$:
  - suppose matrix is in REF
  - take the pivot cols of it!
  - linear dependencies from REF are same as linear dependencies of the original matrix
  - so the basis is the same exact pivot cols
  - notice that if a free variable col can be created from some linear combination of pivot cols in the REF, they can be created with the same linear combination of the same pivot cols of the original matrix!

- _rank_ is the dimension of the vector space spanned by a matrix's columns
/* 
HOMEWORK TODO:
6d how to format solution set
*/

/*
exam 1:
1.1-1.5
1.7-1.9
2.1-2.3
2.8-2.9
- null space, column space, basis
*/