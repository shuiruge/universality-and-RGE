<TeXmacs|2.1>

<style|book>

<\body>
  <section|Basic Idea>

  <subsection|From Self-Similarity to Pattern Recognition>

  There are many kinds of self-similarity in Nature. Turbulence, for
  instance, has self-similarity at the critical point of parameters. This
  self-similarity indicates that, when you zoom-in a picture of turbulence,
  you should find that the original consists of many smaller turbulence each
  of which looks quite like the original. By saying \Plooks like\Q, we mean
  they share the same \Ppattern\Q. That is, <with|font-shape|italic|they are
  not exactly the same, but same in pattern, which is recognized by our
  brain.>

  Pattern recognization can also be made by Boltzmann machine (BM)
  <\footnote>
    An example of deep Boltzmann machine used for pattern abstraction on the
    MNIST dataset can be found <hlink|here|https://github.com/shuiruge/energymodel/blob/main/experiments/Energy_Model_on_MNIST.ipynb>.
  </footnote>, which is a simplified but still efficient model of human
  brain. In Boltzmann machine, two pictures are recognized as the same
  pattern if they both locate within the same area of attractor of the
  corresponding Langevin dynamics.

  So, we should connect the operation on the picture of turbulence with the
  Boltzmann machine that recognizes the patterns. That is,
  <with|font-shape|italic|the pictures before and after the operation should
  obey the same Boltzmann machine.>

  In the next several sections, we expand the theme carefully, declaring what
  the configuration space and operation should be described in mathematics.
  And how Boltzmann machine is changed by the operation. This gives birth to
  renormalization group (RG). After all has been clarified, we can see what
  self-similarity really means.

  <section|Renormalization Group>

  <subsection|Configuration Space and Operations>

  First of all, we declare what the configuration space should be. A picture
  is numerically described by a 2D array of float type, the size of which
  determines the precision of the picture. Generally, we should consider the
  continuous version, from which the discrete or array version can be
  deduced, no matter what the precision is. So, a configuration should be
  described by a real scalar field, say <math|\<varphi\><around*|(|x|)>>,
  where <math|x> in the region <math|A> and
  <math|\<varphi\><around*|(|x|)>\<in\>\<bbb-R\>> for each <math|x\<in\>A>.

  Then, the operation of zooming in is nothing but marginalizing some
  component <math|\<varphi\><around*|(|x|)>> in the probability density
  functional (PDF) of <math|\<varphi\>>, <math|p<around*|[|\<varphi\>|]>>,
  which gives the probability density on a configuration <math|\<varphi\>>.

  Apart from the operation of zooming in picture, there are many kinds of
  operation that may be interested in. This hint us to generalize the
  discussion to the most generic case. The mathematical tool for this purpose
  is representation theory <\footnote>
    For representation theory, see Dirac's <with|font-shape|italic|The
    Principles of Quantum Mechanics>.
  </footnote>. Let <math|\| \<varphi\>\<rangle\>> the state of a
  configuration, and <math|<around*|{|\| x\<rangle\>\|x\<in\><with|font|cal|X>|}>>
  a complete orthogonal base, which may not be spatial coordinate. The
  configuration is described by the mode like
  <math|\<varphi\><around*|(|x|)>\<assign\>\<langle\>
  x\|\<varphi\>\<rangle\>>. Now, the <math|\<varphi\><around*|(|x|)>\<in\>\<bbb-C\>>,
  for instance when <math|\|x\<rangle\>> represents Fourier mode. With this,
  the general operation should be nothing but marginalizing some mode
  <math|>in the probability density functional
  <math|p<around*|[|\<varphi\>|]>>.

  <subsection|Boltzmann Machine and Action Functional>

  Boltzmann machine describes the probability density functional of
  configuration <math|\<varphi\>> by a functional called
  <with|font-series|bold|action> in physics, or
  <with|font-series|bold|energy> in machine learning,
  <math|S<around*|[|\<varphi\>|]>\<in\>\<bbb-R\>>, as

  <\equation*>
    <frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\><with|font|cal|X>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathd\><around*|[|<wide|\<psi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>.
  </equation*>

  Notice that for complex variable, we shall use the
  <math|<big|int><rsub|\<bbb-C\>>\<mathd\>z\<mathd\><wide|z|\<bar\>>> type
  integral. Indeed, let <math|z=x+\<mathi\>y>, we have
  <math|\<mathd\>z\<wedge\>\<mathd\><wide|z|\<bar\>>=<around*|(|-2\<mathi\>|)>\<mathd\>x\<wedge\>\<mathd\>y>.
  Even though writing so, it does not mean that <math|z> and
  <math|<wide|z|\<bar\>>> are independent variables, since there are only two
  degree of freedom.

  If the action functional depends only a subset of all modes, say
  <math|<around*|{|\<varphi\><around*|(|x|)>\|x\<in\>V|}>> with
  <math|V\<subset\><with|font|cal|X>>, then we should add a subscript
  <math|V> to action functional, and the probability density functional
  becomes

  <\equation*>
    <frac|\<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathd\><around*|[|<wide|\<psi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<psi\>|]>>>.
  </equation*>

  <subsection|Continuous Symmetries and Gauge Fixing>

  We may have translational symmetry. Let relaxation
  <math|\<varphi\>\<rightarrow\>\<varphi\><rsub|\<ast\>>>, which
  <math|\<varphi\><rsub|\<ast\>>> denotes the attractor on the area of which
  <math|\<varphi\>> sits. Let <math|\<psi\><around*|(|x|)>\<assign\>\<varphi\><around*|(|x+z|)>>
  for constant <math|z>, and relaxation <math|\<psi\>\<rightarrow\>\<psi\><rsub|\<ast\>>>.
  If translational symmetry holds, we shoud expect that
  <math|\<psi\><rsub|\<ast\>><around*|(|x|)>=\<varphi\><rsub|\<ast\>><around*|(|x+z|)>>
  and that <math|S<around*|[|\<varphi\><rsub|\<ast\>>|]>=S<around*|[|\<psi\><rsub|\<ast\>>|]>>.
  This implies a gauge problem: the extremum of <math|S> is not a single
  value, but a sub-manifold along the symmetry.

  The same holds for any other continous symmetry, such as rotational
  symmetry.

  To deal with this gauge problem, consider a Boltzmann machine that is to
  learn a rectangle. It will relax a perturbed rectangle to the \Pstandard\Q
  one, the learned pattern. This learning task encounters the translational
  symmetry: a rectangle is still the same rectangle after being
  translationally moved. The method to solve this problem is gauge fixing.
  For instance, the dataset is a colleciton of hand-drawn rectangle images,
  and <math|\<varphi\>> represents the gray level in range
  <math|<around*|[|0,1|]>>. We are to move all images in dataset to be
  centered at the original. This can be done by shifting
  <math|x\<rightarrow\>x-m> where <math|m\<assign\>mean<around*|(|<around*|{|x\|\<varphi\><around*|(|x|)>\<gtr\>0|}>|)>>.
  Because of central limit theorem, this <math|m> is stable for random
  perturbation. After this shifting, all images are properly centered, and
  the gauge is fixed.

  This can be seen as a re-definition of coordinates. Indeed, in the case of
  rotational symmetry, we re-define the Cartesian coordinates to polar
  coordinates. As in the case of translational symmetry, this re-definition
  of coordinates fixes the gauge caused by rotational symmetry.

  <subsection|From Operation to Renormalization Group>

  Next, we perform the operation that marginalizes some modes. Let
  <math|V<rprime|'>\<subset\>V>. Marginalizing the modes in
  <math|V\\V<rprime|'>> results in

  <\equation*>
    <big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<varphi\>|\<bar\>><around*|(|x|)>|]>
    <frac|\<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathd\><around*|[|<wide|\<psi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<psi\>|]>>>.
  </equation*>

  On the other hand, this probability density functional of configuration
  should also be described by a Boltzmann machine, which has action
  functional <math|S<rsub|V<rprime|'>>>.

  <\equation*>
    <big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<varphi\>|\<bar\>><around*|(|x|)>|]>
    <frac|\<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathd\><around*|[|<wide|\<psi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<psi\>|]>>>=<frac|\<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V<rprime|'>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathd\><around*|[|<wide|\<psi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<psi\>|]>>>.
  </equation*>

  This equation has the solution

  <\equation*>
    \<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<varphi\>|]>>=C
    <big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<varphi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>,
  </equation*>

  where <math|C> is independent of <math|\<varphi\>>. This is the
  <with|font-series|bold|renormalization group>.

  Indeed, by applying <math|<big|prod><rsub|x\<in\>V<rprime|'>><big|int><rsub|\<bbb-C\><rsup|2>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<varphi\>|\<bar\>><around*|(|x|)>|]>>
  on both sides, we find up to a constant,

  <\equation*>
    <big|prod><rsub|x\<in\>V<rprime|'>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<varphi\>|\<bar\>><around*|(|x|)>|]>\<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<varphi\>|]>>=<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<varphi\>|\<bar\>><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>,
  </equation*>

  which is the starting point of deriving non-perturbative renormalization
  group equation given by <hlink|Aoki|https://www.worldscientific.com/doi/abs/10.1142/S0217979200000923>,
  equation (77). If <math|V<rprime|'>\<approx\>V>, the integration in the
  solution can be simplified by linear approximation, which turns to be the
  renormalizaiton group equation.

  <subsection|Self-Similarity in Renormalization Group>

  By the previous discussion, the same in pattern means the same in Boltzmann
  machine. This implies the equality of actional functional, before and after
  the operation. That is, <math|S<rsub|V>=S<rsub|V<rprime|'>>>.

  <section|Renormalization Group Equation>

  <subsection|Deriving Renormalization Group Equation>

  Consider a continuous family of <math|V>,
  <math|<around*|{|V<around*|(|t|)>\|t\<in\><around*|[|0,1|]>|}>>, such that
  <math|V<around*|(|0|)>=V> and <math|V<around*|(|1|)>=V<rprime|'>>, and that
  <math|V<around*|(|t|)>\<subset\>V<around*|(|t<rprime|'>|)>> as long as
  <math|t\<gtr\>t<rprime|'>>. This family describes a \Pcontinuous
  compression\Q from <math|V> to <math|V<rprime|'>>, which in turn gives
  birth to a functional autonomous differential equation of
  <math|S<rsub|V<around*|(|t|)>>>, called renormalization group equation
  (RGE).

  Now, we are to derive the explicit form of this equation. Given <math|t>,
  the first step is separating <math|\<varphi\><around*|(|x|)>> as
  <math|<around*|{|\<varphi\><around*|(|x|)>\|x\<in\>V<around*|(|t|)>|}>> and
  <math|<around*|{|\<varphi\><around*|(|x|)>\|x\<in\>\<mathd\>V<around*|(|t|)>|}>>,
  where <math|\<mathd\>V<around*|(|t|)>\<assign\>V<around*|(|t|)>\\V<around*|(|t+\<mathd\>t|)>>
  To make it apparent, we use <math|\<phi\>> for the later. So, the action
  functional <math|S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>|]>> is
  turned to be <math|S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>>,
  wherein the <math|\<varphi\>> with <math|x\<in\>V<around*|(|t|)>> may be
  coupled with the <math|\<phi\>>. When <math|\<phi\>=0>, <math|\<varphi\>>
  is decoupled with <math|\<phi\>> in <math|S<rsub|V<around*|(|t|)>>>. Our
  aim is to derive the difference between
  <math|S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>> and
  <math|S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>|]>>, where
  the <math|\<varphi\>> in both action functional run over the same
  <math|V<around*|(|t+\<mathd\>t|)>>. With this declaration, the
  renormalization group becomes

  <\equation*>
    exp<around*|(|-S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>|]>|)>=C
    <big|prod><rsub|x\<in\>\<mathd\>V<around*|(|t|)>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<phi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<phi\>|\<bar\>><around*|(|x|)>|]>
    exp<around*|(|-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>|)>.
  </equation*>

  By multiplying <math|exp<around*|(|S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>|)>>
  on both sides, we get

  <\equation*>
    exp<around*|(|-S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>|]>+S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>|)>=C
    <big|prod><rsub|x\<in\>\<mathd\>V<around*|(|t|)>><big|int><rsub|\<bbb-C\>>\<mathd\><around*|[|\<phi\><around*|(|x|)>|]>\<mathd\><around*|[|<wide|\<phi\>|\<bar\>><around*|(|x|)>|]>exp<around*|(|-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>+S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>|)>.
  </equation*>

  \;

  Now, we are to expand the term in the integrand,
  <math|S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>>, by
  <math|\<phi\>>. Recall that the <math|S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>,\<phi\>|]>>
  is short for <math|S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>,<wide|\<varphi\>|\<bar\>>,\<phi\>,<wide|\<phi\>|\<bar\>>|]>>.
  A formal expansion at the first order shall be<\footnote>
    To declare the first order expansion, consider the example that
    <math|S<around*|[|\<phi\>|]>=<big|int>\<mathd\>x f<around*|(|x|)>
    \<phi\><around*|(|x|)>>, where <math|f,\<phi\>\<in\>\<bbb-R\>>. To make
    it complex, we convert it to Fourier space. Namely,
    <math|S<around*|[|\<phi\>|]>=<big|int>\<mathd\>p
    f<around*|(|p|)><wide|\<phi\>|\<bar\>><around*|(|p|)>>. But since
    <math|S<around*|[|\<phi\>|]>\<in\>\<bbb-R\>>, we instead consider
    <math|S<around*|[|\<phi\>|]>\<equiv\><around*|(|1/2|)><around*|(|S<around*|[|\<phi\>|]>+<wide|S|\<bar\>><around*|[|\<phi\>|]>|)>=<around*|(|1/2|)><big|int>\<mathd\>p<around*|[|f<around*|(|p|)><wide|\<phi\>|\<bar\>><around*|(|p|)>+<wide|f|\<bar\>><around*|(|p|)>\<phi\><around*|(|p|)>|]>>.
    Formally, regarding <math|\<phi\>> and <math|<wide|\<phi\>|\<bar\>>> as
    different variables, which is what \Pformally\Q means, we have
    <math|f<around*|(|p|)>=2 \<delta\>S/\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>>
    and <math|<wide|f|\<bar\>><around*|(|p|)>=2\<delta\>S/\<delta\>\<phi\><around*|(|p|)>>.
    So, we have <math|S<around*|[|\<phi\>|]>=<big|int>\<mathd\>p<around*|[|<around*|(|\<delta\>S/\<delta\>\<phi\><around*|(|p|)>|)>
    \<phi\><around*|(|p|)>+<around*|(|\<delta\>S/\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>|)>
    <wide|\<phi\>|\<bar\>><around*|(|p|)>|]>>. The key is the
    \Psymmetization\Q step <math|S<around*|[|\<phi\>|]>\<equiv\><around*|(|1/2|)><around*|(|S<around*|[|\<phi\>|]>+<wide|S|\<bar\>><around*|[|\<phi\>|]>|)>>.
  </footnote>

  <\equation*>
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>+<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>><around*|[|\<varphi\>,0|]><wide|\<phi\>|\<bar\>><around*|(|x|)>.
  </equation*>

  From <math|S<rsub|V<around*|(|t|)>>\<in\>\<bbb-R\>>, we get
  <math|<wide|\<delta\>S<rsub|V<around*|(|t|)>>/\<delta\>\<phi\><around*|(|x|)>|\<bar\>>=\<delta\>S<rsub|V<around*|(|t|)>>/\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>>.
  At the second order, it is<\footnote>
    A formal expansion should be

    <\equation*>
      <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x\<mathd\>y
      <wide|\<phi\>|\<bar\>><around*|(|x|)><frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|y|)>>\<phi\><around*|(|y|)>+<frac|1|2><big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x\<mathd\>y
      \<phi\><around*|(|x|)><frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|y|)>>\<phi\><around*|(|y|)>+<frac|1|2><big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x\<mathd\>y
      <wide|\<phi\>|\<bar\>><around*|(|x|)><frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\><wide|\<phi\>|\<bar\>><around*|(|y|)>><wide|\<phi\>|\<bar\>><around*|(|y|)>.
    </equation*>

    But, we suppose that both <math|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>/\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|y|)>>
    and <math|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>/\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\><wide|\<phi\>|\<bar\>><around*|(|y|)>>
    vanish. To declare this, we consider the example that
    <math|S<around*|[|\<phi\>|]>=<around*|(|1/2|)><big|int>\<mathd\>x\<mathd\>y
    f<around*|(|x,y|)> \<phi\><around*|(|x|)> \<phi\><around*|(|y|)>>, where
    <math|f,\<phi\>\<in\>\<bbb-R\>>. To make it complex, we convert it to
    Fourier space. Namely, <math|S<around*|[|\<phi\>|]>=<around*|(|1/2|)><big|int>\<mathd\>p\<mathd\>p<rprime|'>f<around*|(|p,p<rprime|'>|)><wide|\<phi\>|\<bar\>><around*|(|p|)>\<phi\><around*|(|p<rprime|'>|)>>,
    where <math|f<around*|(|p,p<rprime|'>|)>\<assign\><big|int>\<mathd\>x\<mathd\>y
    f<around*|(|x,y|)> exp<around*|(|\<mathi\>p x-\<mathi\>p<rprime|'>y|)>>.
    So, there is only the <math|<wide|\<phi\>|\<bar\>>\<phi\>>-term.
    Formally, regarding <math|\<phi\>> and <math|<wide|\<phi\>|\<bar\>>> as
    different variables, which is what \Pformally\Q means, we have
    <math|f<around*|(|p,p<rprime|'>|)>=2 \<delta\><rsup|2>S/\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>\<delta\>\<phi\><around*|(|p<rprime|'>|)>>.
    So, we have, at the second order, <math|S<around*|[|\<phi\>|]>=<big|int>\<mathd\>p\<mathd\>p<rprime|'><around*|(|\<delta\><rsup|2>S/\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>\<delta\>\<phi\><around*|(|p<rprime|'>|)>|)>
    <wide|\<phi\>|\<bar\>><around*|(|p|)>\<phi\><around*|(|p<rprime|'>|)>>.
  </footnote>

  <\equation*>
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x\<mathd\>y
    <wide|\<phi\>|\<bar\>><around*|(|x|)><frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|y|)>>\<phi\><around*|(|y|)>.
  </equation*>

  Since <math|S<rsub|V<around*|(|t|)>>\<in\>\<bbb-R\>>,
  <math|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>/\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|y|)>>
  is Hermitian, that is

  <\equation*>
    <wide|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|y|)>>|\<bar\>>=<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|y|)>\<delta\>\<phi\><around*|(|x|)>>.
  </equation*>

  So, up to the second order, we have

  <\align>
    <tformat|<table|<row|<cell|>|<cell|-S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>,\<phi\>|]>+S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>>>|<row|<cell|=>|<cell|-
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>-<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>><around*|[|\<varphi\>,0|]><wide|\<phi\>|\<bar\>><around*|(|x|)>>>|<row|<cell|>|<cell|-<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'>
    <wide|\<phi\>|\<bar\>><around*|(|x|)><frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|x<rprime|'>|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x<rprime|'>|)>>>|<row|<cell|>|<cell|-\<cdots\>>>>>
  </align>

  So, up to the second order, the integral is a multi-dimensional complex
  Gaussian, which has result as<\footnote>
    For complex Gaussian integral, see the project:
    <hlink|github.com/shuiruge/gaussian-integral|https://github.com/shuiruge/gaussian-integral>.
  </footnote>

  <\small>
    <\equation*>
      exp<around*|(|<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x\<mathd\>y<frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]><around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>>\<delta\>\<phi\>><around*|[|\<varphi\>,0|]>|)><rsup|-1><around*|(|x,y|)><frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|y|)>><around*|[|\<varphi\>,0|]>-<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
      \ ln<around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>|)>+Const|)>,
    </equation*>
  </small>

  where the inverse operator is defined by

  <\equation*>
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'><frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|x<rprime|'>|)>><around*|[|\<varphi\>,0|]><around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>>\<delta\>\<phi\>><around*|[|\<varphi\>,0|]>|)><rsup|-1><around*|(|x<rprime|'>,y|)>=\<delta\><around*|(|x-y|)>.
  </equation*>

  The other terms can be seen as a perturbative expansion based on this
  Gaussian term, and thus all are proportional to higher order of
  <math|<around*|\||\<mathd\>V<around*|(|t|)>|\|>>, being omittable. So,
  letting

  <\equation*>
    \<mathd\>S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>|]>\<assign\>S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>|]>-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>,
  </equation*>

  we arrive at a differential equation, up to a <math|\<varphi\>>-independent
  term,

  <\align>
    <tformat|<table|<row|<cell|\<mathd\>S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>|]>=>|<cell|
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    \ ln<around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|x|)>\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>|)>>>|<row|<cell|->|<cell|<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x\<mathd\>y<frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]><around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>>\<delta\>\<phi\>><around*|[|\<varphi\>,0|]>|)><rsup|-1><around*|(|x,y|)><frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|y|)>><around*|[|\<varphi\>,0|]>.>>>>
  </align>

  It is called (non-perturbative) <with|font-series|bold|renormalization
  group equation>. This equation is also called the Wegner-Houghton equation.
  Wegner and Houghton first gave this formula in 1972 <\footnote>
    <with|font-shape|italic|Renormalization Group Equation for Critical
    Phenomena> (DOI: 10.1103/PhysRevA.8.401).
  </footnote>.

  <subsection|Self-Similarity May Relate to Limit Circle>

  How is self-similarity characterized by this renormalization group
  equation? An educated guess is that self-similarity is a limit circle of
  this autonomous differential equation. It starts at a point and travels
  along a circle. Finally it goes back to the starting point: the
  self-similarity. And then, it starts the same trip again.

  <section|Construction of Action Functional>

  <subsection|Vanilla Boltzmann Machine with Locality>

  We are to consider the explicit form of the action functional for, for
  instance, picture. In this case, the <math|x> is <math|2>-dimensional
  spatial coordinates. For vanilla Boltzmann machine, the action functional
  would be

  <\equation*>
    S<around*|[|\<varphi\>|]>=<big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>x
    b<around*|(|x|)> \<varphi\><around*|(|x|)>+<frac|1|2><big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>x
    \<mathd\>x<rprime|'> \<varphi\><around*|(|x|)>
    W<around*|(|x,x<rprime|'>|)> \<varphi\><around*|(|x<rprime|'>|)>
  </equation*>

  for some bias <math|b> and kernel <math|W>. In the case of field theory,
  the kernel would be <math|W<around*|(|x,x<rprime|'>|)>=-\<delta\><around*|(|x,x<rprime|'>|)>\<times\><around*|[|<around*|(|1/2|)>
  <around*|(|\<partial\><rsup|2>/\<partial\>x<rsup|2>|)>+V<around*|(|x|)>|]>>
  for some \Pmass function\Q <math|V>. This form of kernel is local which
  means <math|W<around*|(|x,y|)>\<propto\>\<delta\><around*|(|x,y|)>>. Under
  the locality assumption, we have the most general form of kernel:
  <math|W<around*|(|x,x<rprime|'>|)>=\<delta\><around*|(|x-x<rprime|'>|)>
  w<around*|(|x|)>>, where

  <\equation*>
    w<around*|(|x|)>=a<rsub|0><around*|(|x|)>+a<rsub|1><around*|(|x|)>
    \<partial\><rsup|2>+\<cdots\>+a<rsub|n><around*|(|x|)>\<partial\><rsup|2n>+\<cdots\>.
  </equation*>

  Based on these, we propose a more symmetric form, as

  <\equation*>
    S<around*|[|\<varphi\>|]>=<big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>x
    <around*|[|b<around*|(|x|)>\<varphi\><around*|(|x|)>+<frac|1|2>a<rsub|0><around*|(|x|)>
    \<varphi\><rsup|2><around*|(|x|)>+<frac|1|2>a<rsub|1><around*|(|x|)><around*|(|\<partial\>\<varphi\><around*|(|x|)>|)><rsup|2>+\<cdots\>|]>
  </equation*>

  The higher derivatives are involved, the larger range of \Pconnections\Q
  between the \Pneurons\Q. <\footnote>
    Here the words \Pconnection\Q and \Pneuron\Q come from the analogy of
    Boltzmann machine with human brain. The <math|W<around*|(|x,y|)>> is
    analogy to the weight between the neurons at <math|x> and <math|y>.
  </footnote> Indeed, a function can be recovered in a larger range if we
  have higher derivatives on the origin.

  The parameter space of <math|S<around*|[|\<varphi\>|]>> is
  <math|<around*|{|b,a<rsub|0>,a<rsub|1>,\<ldots\>|}>>.

  <subsection|RGE of Vanilla BM with Locality Has Fixed Points at Everywhere>

  In this section, we deduce the renormalization group equation to the case
  of vanilla Boltzmann machine proposed previously. The <math|\<varphi\>>,
  <math|b>, and <math|a<rsub|n>> are all real. To eliminate the partial
  derivatives, we convert to the Fourier space.

  In Fourier space, <math|<big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>x
  b<around*|(|x|)> \<varphi\><around*|(|x|)>=<around*|(|1/2|)><big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>p
  <around*|[|<wide|b|\<bar\>><around*|(|p|)>\<varphi\><around*|(|p|)>+b<around*|(|p|)><wide|\<varphi\>|\<bar\>><around*|(|p|)>|]>>.
  And

  <\align>
    <tformat|<table|<row|<cell|>|<cell|<big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>x
    <around*|[|a<rsub|0><around*|(|x|)> \<varphi\><rsup|2><around*|(|x|)>+a<rsub|1><around*|(|x|)>\<partial\>\<varphi\><around*|(|x|)>
    \<partial\>\<varphi\><around*|(|x|)>+\<cdots\>|]>>>|<row|<cell|=>|<cell|<big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>p\<mathd\>p<rprime|'>
    <wide|\<varphi\>|\<bar\>><around*|(|p|)><around*|[|a<rsub|0><around*|(|p-p<rprime|'>|)>+a<rsub|1><around*|(|p-p<rprime|'>|)>
    <around*|(|p\<cdot\>p<rprime|'>|)>+a<rsub|2><around*|(|p-p<rprime|'>|)><around*|(|p\<cdot\>p<rprime|'>|)><rsup|2>+\<cdots\>|]>
    \<varphi\><around*|(|p<rprime|'>|)>>>|<row|<cell|=>|<cell|<big|int><rsub|\<bbb-R\><rsup|n>>\<mathd\>p\<mathd\>p<rprime|'><wide|\<varphi\>|\<bar\>><around*|(|p|)>A<around*|(|p,p<rprime|'>|)>\<varphi\><around*|(|p<rprime|'>|)>,>>>>
  </align>

  where <math|A<around*|(|p,p<rprime|'>|)>\<assign\><big|sum><rsub|n=0><rsup|+\<infty\>>a<rsub|n><around*|(|p-p<rprime|'>|)><around*|(|p\<cdot\>p<rprime|'>|)><rsup|n>>.
  Since <math|a<rsub|n><around*|(|x|)>\<in\>\<bbb-R\>>, we have
  <math|<wide|a|\<bar\>><rsub|n><around*|(|p|)>=a<rsub|n><around*|(|-p|)>>,
  and thus <math|A<around*|(|p,p<rprime|'>|)><rsup|\<ast\>>=A<around*|(|p<rprime|'>,p|)>>.
  So, <math|A> is Hermitian.

  To deduce the renormalization group equation, we restrict the Fourier mode
  with <math|V<around*|(|t|)>\<assign\><around*|{|p\<in\>\<bbb-R\><rsup|n>\|<around*|\||p|\|>\<leqslant\>exp<around*|(|t|)>|}>>.
  Thus,

  <\equation*>
    S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>|]>=<frac|1|2><big|int><rsub|V<around*|(|t|)>>\<mathd\>p
    <wide|b|\<bar\>><around*|(|p|)>\<varphi\><around*|(|p|)>+<frac|1|2><big|int><rsub|V<around*|(|t|)>>\<mathd\>p
    b<around*|(|p|)><wide|\<varphi\>|\<bar\>><around*|(|p|)>+<frac|1|2><big|int><rsub|V<around*|(|t|)>>\<mathd\>p\<mathd\>p<rprime|'><wide|\<varphi\>|\<bar\>><around*|(|p|)>A<around*|(|p,p<rprime|'>|)>\<varphi\><around*|(|p<rprime|'>|)>.
  </equation*>

  Then, set <math|t=0>. As before, in the first step, we shall split
  <math|\<varphi\><around*|(|p|)>> by <math|<around*|{|\<varphi\><around*|(|p|)>\|p\<in\>V<around*|(|0|)>|}>>
  and <math|<around*|{|\<varphi\><around*|(|p|)>\|p\<in\>\<mathd\>V|}>> and
  denote the later by <math|\<phi\><around*|(|p|)>>. And then expand
  <math|S<rsub|V<around*|(|\<mathd\>t|)>>> by <math|\<varphi\>> and
  <math|\<phi\>>, as

  <\align>
    <tformat|<table|<row|<cell|S<rsub|V<around*|(|\<mathd\>t|)>><around*|[|\<varphi\>,\<phi\>|]>=>|<cell|S<rsub|V<around*|(|0|)>><around*|[|\<varphi\>,0|]>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|\<mathd\>V>\<mathd\>p
    <wide|b|\<bar\>><around*|(|p|)>\<phi\><around*|(|p|)>+<frac|1|2><big|int><rsub|\<mathd\>V>\<mathd\>p
    b<around*|(|p|)><wide|\<phi\>|\<bar\>><around*|(|p|)>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>p<big|int><rsub|\<mathd\>V>\<mathd\>p<rprime|'><wide|\<varphi\>|\<bar\>><around*|(|p|)>A<around*|(|p,p<rprime|'>|)>\<phi\><around*|(|p<rprime|'>|)>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|\<mathd\>V>\<mathd\>p<big|int><rsub|V<around*|(|0|)>>\<mathd\>p<rprime|'><wide|\<phi\>|\<bar\>><around*|(|p|)>A<around*|(|p,p<rprime|'>|)>\<varphi\><around*|(|p<rprime|'>|)>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|\<mathd\>V>\<mathd\>p<big|int><rsub|\<mathd\>V>\<mathd\>p<rprime|'><wide|\<phi\>|\<bar\>><around*|(|p|)>A<around*|(|p,p<rprime|'>|)>\<phi\><around*|(|p<rprime|'>|)>.>>>>
  </align>

  Formally, we have

  <\equation*>
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>><around*|[|\<varphi\>,0|]>=<frac|1|2>b<around*|(|p|)>+<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>p<rprime|'>A<around*|(|p,p<rprime|'>|)>\<varphi\><around*|(|p<rprime|'>|)>,
  </equation*>

  and

  <\equation*>
    <frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>\<delta\>\<phi\><around*|(|p<rprime|'>|)>><around*|[|\<varphi\>,0|]>=<frac|1|2>A<around*|(|p,p<rprime|'>|)>.
  </equation*>

  The inverse operator of <math|A>, <math|A<rsup|-1>>, has the property
  <math|A A<rsup|-1>=1>, that is <math|<big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>p<rprime|'>
  A<around*|(|p,p<rprime|'>|)>A<rsup|-1><around*|(|p<rprime|'>,p<rprime|''>|)>=\<delta\><around*|(|p-p<rprime|''>|)>>.

  Let us plug these into the renormalization group equation, the second term
  comes to be

  <\align>
    <tformat|<table|<row|<cell|>|<cell|<big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'><frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|p|)>><around*|[|\<varphi\>,0|]><around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>>\<delta\>\<phi\>><around*|[|\<varphi\>,0|]>|)><rsup|-1><around*|(|p,p<rprime|'>|)><frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|p<rprime|'>|)>><around*|[|\<varphi\>,0|]>>>|<row|<cell|=>|<cell|<frac|1|2><big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'><around*|[|<wide|b|\<bar\>><around*|(|p|)>+<big|int><rsub|V<around*|(|0|)>>\<mathd\>q
    A<around*|(|q,p|)><wide|\<varphi\>|\<bar\>><around*|(|q|)>|]>A<rsup|-1><around*|(|p,p<rprime|'>|)><around*|[|b<around*|(|p<rprime|'>|)>+<big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'>A<around*|(|p<rprime|'>,q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>|]>>>|<row|<cell|=>|<cell|<frac|1|2><big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'><wide|b|\<bar\>><around*|(|p|)>A<rsup|-1><around*|(|p,p<rprime|'>|)>b<around*|(|p<rprime|'>|)>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'><big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'><wide|b|\<bar\>><around*|(|p|)>A<rsup|-1><around*|(|p,p<rprime|'>|)>A<around*|(|p<rprime|'>,q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'>
    <wide|\<varphi\>|\<bar\>><around*|(|q|)>A<around*|(|q,p|)>A<rsup|-1><around*|(|p,p<rprime|'>|)>b<around*|(|p<rprime|'>|)>>>|<row|<cell|+>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'><big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'>
    <wide|\<varphi\>|\<bar\>><around*|(|q|)>A<around*|(|q,p|)>A<rsup|-1><around*|(|p,p<rprime|'>|)>A<around*|(|p<rprime|'>,q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>.>>>>
  </align>

  All the terms except for the first vanish. For example,

  <\align>
    <tformat|<table|<row|<cell|>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'><big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'><wide|b|\<bar\>><around*|(|p|)>A<rsup|-1><around*|(|p,p<rprime|'>|)>A<around*|(|p<rprime|'>,q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>>>|<row|<cell|<around*|{|A<rsup|-1>A=1|}>=>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'><big|int><rsub|\<mathd\>V>\<mathd\>p<wide|b|\<bar\>><around*|(|p|)>\<delta\><around*|(|p-q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>>>|<row|<cell|<around*|{|p\<nequiv\>q<rprime|'>|}>=>|<cell|0,>>>>
  </align>

  and

  <\align>
    <tformat|<table|<row|<cell|>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'><big|int><rsub|\<mathd\>V>\<mathd\>p\<mathd\>p<rprime|'>
    <wide|\<varphi\>|\<bar\>><around*|(|q|)>A<around*|(|q,p|)>A<rsup|-1><around*|(|p,p<rprime|'>|)>A<around*|(|p<rprime|'>,q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>>>|<row|<cell|<around*|{|A
    A<rsup|-1>=1|}>=>|<cell|<frac|1|2><big|int><rsub|V<around*|(|0|)>>\<mathd\>q<big|int><rsub|V<around*|(|0|)>>\<mathd\>q<rprime|'><big|int><rsub|\<mathd\>V>\<mathd\>p<rprime|'>
    <wide|\<varphi\>|\<bar\>><around*|(|q|)>\<delta\><around*|(|q-p<rprime|'>|)>A<around*|(|p<rprime|'>,q<rprime|'>|)>\<varphi\><around*|(|q<rprime|'>|)>>>|<row|<cell|<around*|{|q\<nequiv\>p<rprime|'>|}>=>|<cell|0.>>>>
  </align>

  While, for the first term in the renormalization group equation,

  <\equation*>
    <big|int><rsub|\<mathd\>V>\<mathd\>p \ ln<around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\><wide|\<phi\>|\<bar\>><around*|(|p|)>\<delta\>\<phi\><around*|(|p|)>><around*|[|\<varphi\>,0|]>|)>=<big|int><rsub|\<mathd\>V>\<mathd\>p
    \ ln<around*|(|A<around*|(|p,p|)>|)>=\<mathd\>V
    ln<around*|(|A<around*|(|0,0|)>|)>.
  </equation*>

  \;

  Now, all terms in the renormalization group equation are independent of
  <math|\<varphi\>>, so is the <math|\<mathd\>S<rsub|V<around*|(|0|)>><around*|[|\<varphi\>|]>>.
  This means, marginalizing the modes in <math|\<mathd\>V> effects the action
  <math|S<rsub|V><around*|[|\<varphi\>|]>> by adding a
  <math|\<varphi\>>-independent \Pconstant\Q, which is equivalent to simply
  removing the modes from <math|S<rsub|V><around*|[|\<varphi\>|]>>.

  In other words, the renormalization group equation of vanilla Boltzmann
  machine with locality has fixed points at everywhere in the parameter space
  <math|<around*|{|b,a<rsub|0>,a<rsub|1>,\<ldots\>|}>>.
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|3.1|3>>
    <associate|auto-11|<tuple|3.2|4>>
    <associate|auto-12|<tuple|4|4>>
    <associate|auto-13|<tuple|4.1|4>>
    <associate|auto-14|<tuple|4.2|5>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-3|<tuple|2|1>>
    <associate|auto-4|<tuple|2.1|1>>
    <associate|auto-5|<tuple|2.2|1>>
    <associate|auto-6|<tuple|2.3|2>>
    <associate|auto-7|<tuple|2.4|2>>
    <associate|auto-8|<tuple|2.5|3>>
    <associate|auto-9|<tuple|3|3>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-3|<tuple|3|3>>
    <associate|footnote-4|<tuple|4|3>>
    <associate|footnote-5|<tuple|5|4>>
    <associate|footnote-6|<tuple|6|4>>
    <associate|footnote-7|<tuple|7|5>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-3|<tuple|3|3>>
    <associate|footnr-4|<tuple|4|3>>
    <associate|footnr-5|<tuple|5|4>>
    <associate|footnr-6|<tuple|6|4>>
    <associate|footnr-7|<tuple|7|5>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      1<space|2spc>Basic Idea <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1>

      <with|par-left|<quote|1tab>|1.1<space|2spc>From Self-Similarity to
      Pattern Recognition <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      2<space|2spc>Renormalization Group <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Configuration Space and
      Operations <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Boltzmann Machine and Action
      Functional <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>Continuous Symmetries and
      Gauge Fixing <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>From Operation to
      Renormalization Group <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>Self-Similarity in
      Renormalization Group <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      3<space|2spc>Renormalization Group Equation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>

      <with|par-left|<quote|1tab>|3.1<space|2spc>Deriving Renormalization
      Group Equation <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>Self-Similarity May Relate
      to Limit Circle <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      4<space|2spc>Construction of Action Functional
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>

      <with|par-left|<quote|1tab>|4.1<space|2spc>Vanilla Boltzmann Machine
      with Locality <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|<quote|1tab>|4.2<space|2spc>RGE of Vanilla BM with
      Locality Has Fixed Points at Everywhere
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>
    </associate>
  </collection>
</auxiliary>