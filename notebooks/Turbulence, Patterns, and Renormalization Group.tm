<TeXmacs|2.1>

<style|generic>

<\body>
  Turbulence, for instance, has self-similarity at the critical point of
  parameters. This self-similarity indicates that, when you zoom-in a picture
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
  Boltzmann machine that recognizes the patterns. That is,
  <with|font-shape|italic|the pictures before and after the operation should
  obey the same Boltzmann machine.> As we will see, this will give birth to
  (non-perturbative) renormalization group.

  First of all, we should declare what the configuration space should be. A
  picture is numerically described by a 2D array of float type, the size of
  which determines the precision of the picture. Generally, we should
  consider the continuous version, while the discrete or array version can be
  deduced from it, no matter what the precision is. So, a configuration
  should be described by a real scalar field, say
  <math|\<varphi\><around*|(|x|)>>, where <math|x> in the region <math|V> and
  <math|\<varphi\><around*|(|x|)>\<in\>\<bbb-R\>> for each <math|x\<in\>V>.

  Boltzmann machine describes the probability of configuration by a scalar
  functional on the configuration space, called
  <with|font-series|bold|action> in physics, or
  <with|font-series|bold|energy> in machine learning, denoted by <math|S>.
  The probability density functional (PDF) of Boltzmann machine is given by

  <\equation*>
    <frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>.
  </equation*>

  Next, we perform the operation that zooms-in the picture. It cuts out a
  smaller region of the picture as a whole. Let it cut out a sub-region
  <math|A\<subset\>V>, so that the outer region of <math|A> is omitted. To
  describe the density of probability within <math|A>, we should integrate
  out the components of configuration that is out of <math|A>, that is,
  <math|<around*|{|\<varphi\><around*|(|x|)>\|x\<in\>V\\A|}>>. Explicitly,

  <\equation*>
    <big|prod><rsub|x\<in\>V\\A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]><frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>.
  </equation*>

  On the other hand, the configuration of the picture after the operation
  should also be described by a Boltzmann machine, which gives the same PDF
  as the previously integrated. So, we have

  <\equation*>
    <big|prod><rsub|x\<in\>V\\A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<varphi\><around*|(|x|)>|]><frac|\<mathe\><rsup|-S<around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>V><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<around*|[|\<psi\>|]>>>=<frac|\<mathe\><rsup|-S<rsub|A><around*|[|\<varphi\>|]>>|<big|prod><rsub|x\<in\>A><big|int><rsub|\<bbb-R\>>\<mathd\><around*|[|\<psi\><around*|(|x|)>|]>
    \<mathe\><rsup|-S<rsub|A><around*|[|\<psi\>|]>>>,
  </equation*>

  where in the right hand side, <math|S<rsub|A>> is the action functional of
  the new Boltzmann machine. This equation has the solution

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

  By the previous discussion, the same in pattern means the same in Boltzmann
  machine. This implies the equality of actional functional, before and after
  zooming-in the picture. That is, <math|S=S<rsub|A>>.
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnr-1|<tuple|1|1>>
  </collection>
</references>