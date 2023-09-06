<TeXmacs|2.1>

<style|generic>

<\body>
  Turbulence, for instance, has self-similarity at the critical point of
  parameters. This self-similarity indicates that, when you zoom in a picture
  of turbulence, you should find that the original consists of many smaller
  turbulence each of which looks quite like the original. By saying \Plooks
  like\Q, we mean they share the same \Ppattern\Q. That is,
  <with|font-shape|italic|they are not exactly the same, but same in pattern,
  which is recognized by our brain.>

  Pattern recognization can also be made by Boltzmann machine <\footnote>
    An example of deep Boltzmann machine used for pattern abstraction on the
    MNIST dataset can be found <hlink|here|https://github.com/shuiruge/energymodel/blob/main/experiments/Energy_Model_on_MNIST.ipynb>.
  </footnote>, which is a simplified but still efficient model of human
  brain. In Boltzmann machine, two pictures are recognized as the same
  pattern if they both locate within the same area of attractor of the
  corresponding Langevin dynamics.

  So, we should connect the operation on the picture of turbulence with the
  Boltzmann machine that recognizes the patterns. This will give birth to
  (non-perturbative) renormalization group.

  First of all, we should declare the configuration space. A picture is
  numerically described by a 2D array of float type. So, generally, a
  configuration can be described by a real scalar field, say
  <math|\<varphi\><around*|(|x|)>>, where <math|x> in the region <math|V> and
  <math|\<varphi\><around*|(|x|)>\<in\>\<bbb-R\>> for each <math|x\<in\>V>.

  Boltzmann machine describe the probability of configuration by a scalar
  functional on the configuration space, called
  <with|font-series|bold|action> in physics, or
  <with|font-series|bold|energy> in machine learning, denoted by <math|S>.
  The probability density functional (PDF) is given by

  <\equation*>
    <frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>.
  </equation*>

  Next, we perform the operation that zooms in the picture. It involves two
  steps: cutting out a smaller region of the picture, and rescaling <math|x>.
  The first step cuts out a sub-region <math|A\<subset\>V>, so that the outer
  region of <math|A> is not cared. To describe the density of probability
  within <math|A>, we should integrate out the component of configuration
  which is out of <math|A>, that is, <math|<around*|{|\<varphi\><around*|(|x|)>\|x\<in\>V\\A|}>>.
  This gives another <with|font-shape|italic|form> of PDF, which is again
  given by another Boltzmann machine with configuration sits on <math|A> and
  with a new action, denoted by <math|S<rsub|A>>. That is,

  <\equation*>
    <big|prod><rsub|x\<in\>V\\A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]><frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>=<frac|\<mathe\><rsup|-S<rsub|A><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|A><around*|[|\<psi\>|]>>>.
  </equation*>

  It has the solution

  <\equation*>
    \<mathe\><rsup|-S<rsub|A><around*|[|\<varphi\>|]>>=<big|prod><rsub|x\<in\>V\\A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<varphi\>|]>>.
  </equation*>

  Applying <math|<big|prod><rsub|x\<in\>A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>>
  on both sides, we find

  <\equation*>
    <big|prod><rsub|x\<in\>A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>\<mathe\><rsup|-S<rsub|A><around*|[|\<varphi\>|]>>=<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<varphi\>|]>>,
  </equation*>

  which is the starting point of deriving non-perturbative renormalization
  group given by <hlink|Aoki|https://www.worldscientific.com/doi/abs/10.1142/S0217979200000923>,
  equation (77). If <math|A\<approx\>V>, the integration in the solution can
  be simplified by linear approximation, which turns to be the
  renormalizaiton group equation.

  The second step of operation, i.e. rescaling <math|x>, is taken within the
  action functional itself.

  By the previous discussion, the same in pattern means the same in PDF given
  by Boltzmann machine. This implies the equality of actional functional,
  before and after the operation that zooms in the picture. That is,
  <math|S=S<rsub|A>>.
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|?>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|?>>
  </collection>
</references>