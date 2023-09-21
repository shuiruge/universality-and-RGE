<TeXmacs|2.1>

<style|generic>

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
  continuous version, while the discrete or array version can be deduced from
  it, no matter what the precision is. So, a configuration should be
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
  x\|\<varphi\>\<rangle\>>. With this, the general operation should be
  nothing but marginalizing some mode <math|>in the probability density
  functional <math|p<around*|[|\<varphi\>|]>>.

  <subsection|Boltzmann Machine>

  Boltzmann machine describes the probability density functional of
  configuration <math|\<varphi\>> by a functional called
  <with|font-series|bold|action> in physics, or
  <with|font-series|bold|energy> in machine learning,
  <math|S<around*|[|\<varphi\>|]>>, as

  <\equation*>
    <frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\><with|font|cal|X>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>.
  </equation*>

  If the action functional depends only a subset of all modes, say
  <math|<around*|{|\<varphi\><around*|(|x|)>\|x\<in\>V|}>> with
  <math|V\<subset\><with|font|cal|X>>, then we should add a subscript
  <math|V> to action functional, and the probability density functional
  becomes

  <\equation*>
    <frac|\<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
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

  <subsection|Renormalization Group>

  Next, we perform the operation that marginalizes some modes. Let
  <math|V<rprime|'>\<subset\>V>. Marginalizing the modes in
  <math|V\\V<rprime|'>> results in

  <\equation*>
    <big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]><frac|\<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<psi\>|]>>>.
  </equation*>

  On the other hand, this probability density functional of configuration
  should also be described by a Boltzmann machine, which has action
  functional <math|S<rsub|V<rprime|'>>>.

  <\equation*>
    <big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]><frac|\<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<psi\>|]>>>=<frac|\<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<psi\>|]>>>.
  </equation*>

  This equation has the solution

  <\equation*>
    \<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<varphi\>|]>>=C
    <big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>,
  </equation*>

  where <math|C> is independent of <math|\<varphi\>>. This is the
  <with|font-series|bold|renormalization group>.

  Indeed, by applying <math|<big|prod><rsub|x\<in\>V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>>
  on both sides, we find up to a constant,

  <\equation*>
    <big|prod><rsub|x\<in\>V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathe\><rsup|-S<rsub|V<rprime|'>><around*|[|\<varphi\>|]>>=<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|V><around*|[|\<varphi\>|]>>,
  </equation*>

  which is the starting point of deriving non-perturbative renormalization
  group equation given by <hlink|Aoki|https://www.worldscientific.com/doi/abs/10.1142/S0217979200000923>,
  equation (77). If <math|V<rprime|'>\<approx\>V>, the integration in the
  solution can be simplified by linear approximation, which turns to be the
  renormalizaiton group equation.

  It should be noted that the expression of renormalization group is
  independent of the choice of complete orthogonal base. Indeed, changing
  bases to another complete orthogonal base <math|<around*|{|\|
  y\<rangle\>\|y\<in\><with|font|cal|Y>|}>> involves a unitary transformation
  <math|<wide|U|^>>, which is a collection of <math|\<langle\> x\|
  y\<rangle\>>. Since the product in <math|<big|prod><rsub|x\<in\>V\\V<rprime|'>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>>
  is in fact a wedged product. So, formally, this unitary transformation
  results in an extra term <math|det<around*|(|<wide|U|^>|)>>, which is
  independent of <math|\<varphi\>>, thus can be absorbed into the factor
  <math|C>. This will leave the expression formally invariant.

  <subsection|Self-Similarity in Renormalization Group>

  By the previous discussion, the same in pattern means the same in Boltzmann
  machine. This implies the equality of actional functional, before and after
  the operation. That is, <math|S<rsub|V>=S<rsub|V<rprime|'>>>.

  <section|Renormalization Group Equation>

  <subsection|Renormalization Group Equation>

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
  we start at separating <math|\<varphi\><around*|(|x|)>> as
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
    <big|prod><rsub|x\<in\>\<mathd\>V<around*|(|t|)>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<phi\><around*|(|x|)>|]>
    exp<around*|(|-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>|)>.
  </equation*>

  By multiplying <math|exp<around*|(|S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>|)>>
  on both sides, we get

  <\equation*>
    exp<around*|(|-S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>|]>+S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>|)>=C
    <big|prod><rsub|x\<in\>\<mathd\>V<around*|(|t|)>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<phi\><around*|(|x|)>|]>exp<around*|(|-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>+S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>|)>.
  </equation*>

  We expand the term in the integrand as

  <\align>
    <tformat|<table|<row|<cell|>|<cell|-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,\<phi\>|]>+S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>>>|<row|<cell|=>|<cell|-
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>>>|<row|<cell|>|<cell|-<frac|1|2><big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'>
    <frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|x<rprime|'>|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>\<phi\><around*|(|x<rprime|'>|)>>>|<row|<cell|>|<cell|-<frac|1|6><big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'>
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|''>
    \ <frac|\<delta\><rsup|3>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|x<rprime|'>|)>\<delta\>\<phi\><around*|(|x<rprime|''>|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>\<phi\><around*|(|x<rprime|'>|)>\<phi\><around*|(|x<rprime|''>|)>>>|<row|<cell|>|<cell|-\<cdots\>>>>>
  </align>

  Plugging this expansion back, we find that the first two terms furnishes a
  functional Gaussian integral

  <\equation*>
    <small|C <big|prod><rsub|x\<in\>\<mathd\>V<around*|(|t|)>><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<phi\><around*|(|x|)>|]>
    exp<around*|(|- <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>-<frac|1|2><big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'>
    <frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|x<rprime|'>|)>><around*|[|\<varphi\>,0|]>\<phi\><around*|(|x|)>\<phi\><around*|(|x<rprime|'>|)>|)>.>
  </equation*>

  Since <math|<around*|(|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>/\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|x<rprime|'>|)>|)><around*|[|\<varphi\>,0|]>>
  is real and symmetric on <math|x> and <math|x<rprime|'>>, and
  <math|<around*|{|\| x\<rangle\>\|x\<in\>\<mathd\>V<around*|(|t|)>|}>> is
  complete on the sub-Hilbert-space where the <math|\<phi\>> sits, this
  integral can be integrated out, as <\footnote>
    For functional Gaussian integral, see appendix <reference|appendix:
    Functional Gaussian Integral>.
  </footnote>

  <\equation*>
    <small|C exp<around*|{|<frac|1|2> \ <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'>
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]><around*|[|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\>\<delta\>\<phi\>><around*|[|\<varphi\>,0|]>|]><rsup|-1><around*|(|x,x<rprime|'>|)><frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x<rprime|'>|)>><around*|[|\<varphi\>,0|]>-<frac|1|2>
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    \ ln<around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>|)>|}>>
  </equation*>

  The other terms can be seen as a perturbative expansion based on this
  Gaussian term, and thus all are proportional to higher order of
  <math|<around*|\||\<mathd\>V<around*|(|t|)>|\|>>, thus omittable. So,
  letting

  <\equation*>
    \<mathd\>S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>|]>\<assign\>S<rsub|V<around*|(|t+\<mathd\>t|)>><around*|[|\<varphi\>|]>-S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>,0|]>,
  </equation*>

  we arrive at a differential equation, up to a <math|\<varphi\>>-independent
  term,

  <\align>
    <tformat|<table|<row|<cell|\<mathd\>S<rsub|V<around*|(|t|)>><around*|[|\<varphi\>|]>=>|<cell|<frac|1|2>
    \ <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x<rprime|'>
    <frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]><around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\>\<delta\>\<phi\>><around*|[|\<varphi\>,0|]>|)><rsup|-1><around*|(|x,x<rprime|'>|)><frac|\<delta\>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x<rprime|'>|)>><around*|[|\<varphi\>,0|]>>>|<row|<cell|->|<cell|<frac|1|2>
    <big|int><rsub|\<mathd\>V<around*|(|t|)>>\<mathd\>x
    \ ln<around*|(|<frac|\<delta\><rsup|2>S<rsub|V<around*|(|t|)>>|\<delta\>\<phi\><around*|(|x|)>\<delta\>\<phi\><around*|(|x|)>><around*|[|\<varphi\>,0|]>|)>,>>>>
  </align>

  which is called (non-perturbative) <with|font-series|bold|renormalization
  group equation>.

  <subsection|Self-Similarity May Relate to Limit Circle>

  How is self-similarity characterized by this renormalization group
  equation? An educated guess is that self-similarity is a limit circle of
  this autonomous differential equation. It starts at a point and travels
  along a circle. Finally it goes back to the starting point: the
  self-similarity. And then, it starts the same trip again.

  <section|Construction of Action Functional>

  <subsection|Vanilla Boltzmann Machine with Locality>

  We are to consider the explicit form of the action functional for the
  pictures of, for instance, turbulence. For vanilla Boltzmann machine, the
  action functional would be

  <\equation*>
    S<around*|[|\<varphi\>|]>=<big|int>\<mathd\>x J<around*|(|x|)>
    \<varphi\><around*|(|x|)>+<big|int>\<mathd\>x \<mathd\>y
    \<varphi\><around*|(|x|)> W<around*|(|x,y|)> \<varphi\><around*|(|y|)>
  </equation*>

  for some bias <math|J> and kernel <math|W>. In the case of field theory,
  the kernel would be <math|W<around*|(|x,y|)>=-\<delta\><around*|(|x,y|)>\<times\><around*|[|<around*|(|1/2|)>
  <around*|(|\<partial\><rsup|2>/\<partial\>y<rsup|2>|)>+V<around*|(|y|)>|]>>
  for some \Pmass function\Q <math|V>. This form of kernel is local which
  means <math|W<around*|(|x,y|)>\<propto\>\<delta\><around*|(|x,y|)>>. Under
  the locality assumption, we have the most general form of kernel:
  <math|W<around*|(|x,y|)>=\<delta\><around*|(|x,y|)> w<around*|(|y|)>>,
  where

  <\equation*>
    w<around*|(|x|)>=a<rsub|0><around*|(|x|)>+a<rsub|1><around*|(|x|)>
    \<partial\><rsup|2>+\<cdots\>+a<rsub|n><around*|(|x|)>\<partial\><rsup|2n>+\<cdots\>.
  </equation*>

  In this case, action functional is reduced to

  <\equation*>
    S<around*|[|\<varphi\>|]>=<big|int>\<mathd\>x
    <around*|[|J<around*|(|x|)>\<varphi\><around*|(|x|)>+a<rsub|0><around*|(|x|)>
    \<varphi\><rsup|2><around*|(|x|)>+a<rsub|1><around*|(|x|)>\<varphi\><around*|(|x|)>
    \<partial\><rsup|2>\<varphi\><around*|(|x|)>+\<cdots\>|]>
  </equation*>

  The higher derivatives are involved, the larger range of \Pconnections\Q
  between the \Pneurons\Q. <\footnote>
    Here the words \Pconnection\Q and \Pneuron\Q come from the analogy of
    Boltzmann machine with human brain. The <math|W<around*|(|x,y|)>> is
    analogy to the weight between the neurons at <math|x> and <math|y>.
  </footnote> Indeed, a function can be recovered in a larger range if we
  have higher derivatives on the origin.

  <appendix|Functional Gaussian Integral><label|appendix: Functional Gaussian
  Integral>

  <\theorem>
    [Functional Gaussian Integral]<label|theorem: Functional Gaussian
    Integral> Let <math|A<around*|(|x,x<rprime|'>|)>> and
    <math|b<around*|(|x|)>> real functions with
    <math|A<around*|(|x,x<rprime|'>|)>=A<around*|(|x<rprime|'>,x|)>> for each
    <math|x> and <math|x<rprime|'>>. Suppose that the orthogonal base
    <math|\| x\<rangle\>> is complete, that is
    <math|<big|int><rsub|V>\<mathd\>x\| x\<rangle\>\<langle\>x \|=1> for some
    set <math|V>. Then we have the functional integral

    <\align>
      <tformat|<table|<row|<cell|>|<cell|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<phi\><around*|(|x|)>|]>
      exp<around*|(|-<frac|1|2><big|int><rsub|V>\<mathd\>x
      <big|int><rsub|V>\<mathd\>x<rprime|'> A<around*|(|x,x<rprime|'>|)>
      \<phi\><around*|(|x|)>\<phi\><around*|(|x<rprime|'>|)>-<big|int><rsub|V>\<mathd\>x
      b<around*|(|x|)> \<phi\><around*|(|x|)>|)>>>|<row|<cell|=>|<cell|C
      exp<around*|{|<frac|1|2> \ <big|int><rsub|V>\<mathd\>x
      <big|int><rsub|V>\<mathd\>x<rprime|'>
      b<around*|(|x|)><around*|(|A<rsup|-1>|)><around*|(|x,x<rprime|'>|)>b<around*|(|x<rprime|'>|)>-<frac|1|2>
      <big|int><rsub|V>\<mathd\>x \ ln A<around*|(|x,x|)>|}>,>>>>
    </align>

    where <math|C> is independent of <math|\<phi\>>, and
    <math|<big|int><rsub|V>\<mathd\>x<rprime|'> A<around*|(|x,x<rprime|'>|)>
    <around*|(|A<rsup|-1>|)><around*|(|x<rprime|'>,x<rprime|''>|)>=\<delta\><around*|(|x-x<rprime|''>|)>>.
  </theorem>

  The proof of this theorem needs several tools.

  <\lemma>
    [Multi-Dimensional Gaussian Integral] We have

    <\equation*>
      <big|prod><rsub|\<alpha\>=1><rsup|n><big|int><rsub|\<bbb-R\>>\<mathd\>x<rsup|\<alpha\>>
      exp<around*|(|-<frac|1|2>A<rsub|\<alpha\>\<alpha\><rprime|'>>
      x<rsup|\<alpha\>> x<rsup|\<alpha\><rprime|'>>+b<rsub|\<alpha\>>
      x<rsup|\<alpha\>>|)>=<sqrt|<frac|<around*|(|2\<mathpi\>|)><rsup|n>|det<around*|(|A|)>>>exp<around*|(|<frac|1|2><around*|(|A<rsup|-1>|)><rsup|\<alpha\>\<alpha\><rprime|'>>
      b<rsub|\<alpha\>> b<rsub|\<alpha\><rprime|'>>|)>,
    </equation*>

    where <math|A> is real symmetric matrix and <math|b> is real vector.
  </lemma>

  <\proof>
    Left to reader.
  </proof>

  <\lemma>
    For a real matrix <math|A>, we have

    <\equation*>
      det<around*|(|A|)>=tr ln<around*|(|A|)>.
    </equation*>
  </lemma>

  <\proof>
    Left to reader
  </proof>

  <\lemma>
    Given an operator <math|A> and a complete orthogonal base
    <math|<around*|{|\| x\<rangle\>\|x\<in\>V|}>> with continuous spectrum,
    we have

    <\equation*>
      ln A=<big|int>\<mathd\>x \<mathd\>x<rprime|'> ln\<langle\>
      x\|A\|x<rprime|'> \<rangle\>\| x\<rangle\>\<langle\>x<rprime|'> \|.
    </equation*>
  </lemma>

  <\proof>
    Left to reader.
  </proof>

  <\lemma>
    Given an operator <math|A> and a complete orthogonal base
    <math|<around*|{|\| x\<rangle\>\|x\<in\>V|}>> with continuous spectrum,
    we have

    <\equation*>
      tr ln A=<big|int><rsub|V>\<mathd\>x ln \<langle\> x\|A\|x \<rangle\>.
    </equation*>
  </lemma>

  <\proof>
    To get this result, we start at the conclusion

    <\equation*>
      ln A=<big|int>\<mathd\>x \<mathd\>x<rprime|'> ln\<langle\>
      x\|A\|x<rprime|'> \<rangle\>\| x\<rangle\>\<langle\>x<rprime|'> \|.
    </equation*>

    Recall that, <math|tr ln A> is well-defined in discrete spectrum. For
    instance, given a complete orthogonal base <math|\| \<alpha\>\<rangle\>>
    with discrete spectrum, <math|tr ln A\<assign\><big|sum><rsub|\<alpha\>>\<langle\>
    \<alpha\>\|ln A\|\<alpha\> \<rangle\>>. Then we have

    <\align>
      <tformat|<table|<row|<cell|tr ln A\<assign\>>|<cell|<big|sum><rsub|\<alpha\>>\<langle\>
      \<alpha\>\|ln A\|\<alpha\> \<rangle\>>>|<row|<cell|<around*|{|ln
      A=\<cdots\>|}>=>|<cell|<big|int>\<mathd\>x \<mathd\>x<rprime|'>
      <big|sum><rsub|\<alpha\>>\<langle\> x<rprime|'>\|
      \<alpha\>\<rangle\>\<langle\> \<alpha\>\|x \<rangle\> ln\<langle\>
      x\|A\|x<rprime|'> \<rangle\>>>|<row|<cell|<around*|{|<big|sum><rsub|\<alpha\>>\|
      \<alpha\>\<rangle\>\<langle\> \<alpha\>\|=1|}>=>|<cell|<big|int>\<mathd\>x
      ln \<langle\> x\|A\|x \<rangle\>,>>>>
    </align>

    which is the <math|tr ln A> expressed in continuous spectrum.
  </proof>

  Now, we come to prove the main theorem <reference|theorem: Functional
  Gaussian Integral>.

  <\proof>
    The completeness of <math|\|x \<rangle\>> helps convert to a discrete
    spectrum <math|<around*|{|\| \<alpha\>\<rangle\>\|\<alpha\>\<in\>I|}>>,
    which results in <math|\<phi\><around*|(|x|)>\<assign\>\<langle\>
    x\|\<phi\> \<rangle\>=<big|sum><rsub|\<alpha\>>\<langle\> x\|\<alpha\>
    \<rangle\>\<langle\> \<alpha\>\| \<phi\>\<rangle\>\<backassign\><big|sum><rsub|\<alpha\>>\<langle\>
    x\|\<alpha\> \<rangle\> \<phi\><rsup|\<alpha\>>> where we suppose that
    <math|\<phi\><rsup|\<alpha\>>> is real for each <math|\<alpha\>>,

    <\align>
      <tformat|<table|<row|<cell|>|<cell|- <big|int><rsub|V>\<mathd\>x
      b<around*|(|x|)>\<phi\><around*|(|x|)>>>|<row|<cell|<around*|{|<text|<math|\<phi\>>
      is real>|}>=>|<cell|- <big|int><rsub|V>\<mathd\>x
      b<around*|(|x|)>\<phi\><rsup|\<ast\>><around*|(|x|)>>>|<row|<cell|<around*|{|<big|int><rsub|V>\<mathd\>x
      \|x\<rangle\>\<langle\> x\|=1|}>=>|<cell|-\<langle\> \<phi\>\|
      b\<rangle\>>>|<row|<cell|<around*|{|<big|sum><rsub|\<alpha\>>\|\<alpha\>
      \<rangle\>\<langle\>\<alpha\> \|=1|}>=>|<cell|-b<rsub|\<alpha\>>
      \<phi\><rsup|\<ast\>><rsup|\<alpha\>>>>|<row|<cell|<around*|{|<text|<math|\<phi\><rsup|\<alpha\>>>
      is real>|}>=>|<cell|-b<rsub|\<alpha\>> \<phi\><rsup|\<alpha\>>,>>>>
    </align>

    and

    <\align>
      <tformat|<table|<row|<cell|>|<cell|-<frac|1|2><big|int><rsub|V>\<mathd\>x
      <big|int><rsub|V>\<mathd\>x<rprime|'>
      A<around*|(|x,x|)>\<phi\><around*|(|x|)>\<phi\><around*|(|x<rprime|'>|)>>>|<row|<cell|<around*|{|<big|int><rsub|V>\<mathd\>x
      \|x\<rangle\>\<langle\> x\|=1|}>=>|<cell|-<frac|1|2>\<langle\>\<phi\>
      \|A\| \<phi\>\<rangle\>>>|<row|<cell|<around*|{|<big|sum><rsub|\<alpha\>>\|\<alpha\>
      \<rangle\>\<langle\>\<alpha\> \|=1|}>=>|<cell|-<frac|1|2>A<rsub|\<alpha\>\<alpha\><rprime|'>>
      \<phi\><rsup|\<ast\>><rsup|\<alpha\>>\<phi\><rsup|\<alpha\><rprime|'>>>>|<row|<cell|<around*|{|<text|<math|\<phi\><rsup|\<alpha\>>>
      is real>|}>>|<cell|-<frac|1|2>A<rsub|\<alpha\>\<alpha\><rprime|'>>
      \<phi\><rsup|\<alpha\>>\<phi\><rsup|\<alpha\><rprime|'>>.>>>>
    </align>

    With these, the integral turns to be

    <\equation*>
      C <big|prod><rsub|\<alpha\>=1><rsup|n><big|int><rsub|\<bbb-R\>>\<mathd\>\<phi\><rsup|\<alpha\>>
      exp<around*|(|-<frac|1|2>A<rsub|\<alpha\>\<alpha\><rprime|'>>
      \<phi\><rsup|\<alpha\>>\<phi\><rsup|\<alpha\><rprime|'>>-b<rsub|\<alpha\>>\<phi\><rsup|\<alpha\>>|)>,
    </equation*>

    where <math|C\<assign\>det<around*|(|U|)>> and unitary matrix
    <math|U<rsub|x,\<alpha\>>\<assign\>\<langle\> x\|\<alpha\> \<rangle\>>.
    It gives

    <\equation*>
      C<rprime|'> exp<around*|(|<frac|1|2>
      \ b<rsub|\<alpha\>><around*|(|A<rsup|-1>|)><rsup|\<alpha\>\<alpha\><rprime|'>>b<rsub|\<alpha\><rprime|'>>-<frac|1|2>
      tr ln A|)>,
    </equation*>

    where <math|C<rprime|'>\<assign\><sqrt|<around*|(|2\<mathpi\>|)><rsup|n>>
    C>. The final step is converting from <math|\| \<alpha\>\<rangle\>> back
    to <math|\| x\<rangle\>>. The first term naturally goes to

    <\equation*>
      <frac|1|2> \ <big|int><rsub|V>\<mathd\>x
      <big|int><rsub|V>\<mathd\>x<rprime|'>
      b<around*|(|x|)><around*|(|A<rsup|-1>|)><around*|(|x,x<rprime|'>|)>b<around*|(|x<rprime|'>|)>.
    </equation*>

    And with the aid of formula <math|tr ln A=<big|int><rsub|V>\<mathd\>x ln
    \<langle\> x\|A\|x \<rangle\>>, the second term gives

    <\equation*>
      -<frac|1|2> <big|int><rsub|V>\<mathd\>x \ ln A<around*|(|x,x|)>.
    </equation*>

    Altogether, we get the final expression

    <\equation*>
      C<rprime|'> exp<around*|{|<frac|1|2> \ <big|int><rsub|V>\<mathd\>x
      <big|int><rsub|V>\<mathd\>x<rprime|'>
      b<around*|(|x|)><around*|(|A<rsup|-1>|)><around*|(|x,x<rprime|'>|)>b<around*|(|x<rprime|'>|)>-<frac|1|2>
      <big|int><rsub|V>\<mathd\>x \ ln A<around*|(|x,x|)>|}>.
    </equation*>
  </proof>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|appendix: Functional Gaussian Integral|<tuple|A|5>>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|3.1|3>>
    <associate|auto-11|<tuple|3.2|4>>
    <associate|auto-12|<tuple|4|4>>
    <associate|auto-13|<tuple|4.1|4>>
    <associate|auto-14|<tuple|A|5>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-3|<tuple|2|1>>
    <associate|auto-4|<tuple|2.1|1>>
    <associate|auto-5|<tuple|2.2|1>>
    <associate|auto-6|<tuple|2.3|2>>
    <associate|auto-7|<tuple|2.4|2>>
    <associate|auto-8|<tuple|2.5|3>>
    <associate|auto-9|<tuple|3|3>>
    <associate|definition:Renormalization Group|<tuple|1|?>>
    <associate|equation:RG|<tuple|2|?>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-3|<tuple|3|4>>
    <associate|footnote-4|<tuple|4|4>>
    <associate|footnote-5|<tuple|5|5>>
    <associate|footnote-6|<tuple|6|?>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-3|<tuple|3|4>>
    <associate|footnr-4|<tuple|4|4>>
    <associate|footnr-5|<tuple|5|5>>
    <associate|footnr-6|<tuple|6|?>>
    <associate|theorem: Functional Gaussian Integral|<tuple|1|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Basic
      Idea> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>From Self-Similarity to
      Pattern Recognition <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Renormalization
      Group> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Configuration Space and
      Operations <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Boltzmann Machine
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>Continuous Symmetries and
      Gauge Fixing <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>Renormalization Group
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>Self-Similarity in
      Renormalization Group <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Renormalization
      Group Equation> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>

      <with|par-left|<quote|1tab>|3.1<space|2spc>Renormalization Group
      Equation <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>Self-Similarity May Relate
      to Limit Circle <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Construction
      of Action Functional> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12><vspace|0.5fn>

      <with|par-left|<quote|1tab>|4.1<space|2spc>Vanilla Boltzmann Machine
      with Locality <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Appendix
      A<space|2spc>Functional Gaussian Integral>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>