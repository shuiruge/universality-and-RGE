<TeXmacs|2.1>

<style|generic>

<\body>
  <section|Boltzmann Machine Connects Self-Similarity and Renormalzation
  Group>

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

  <section|Convolutional Neural Network: Continuous Version>

  Convolutional neural network is invented for processing vision related
  tasks, such as picture classification. It has a feedforward architecture
  which involves three kinds of basic layer: convolutional layer, pooling
  layer, and dense layer. Details can be found in
  <hlink|wikipedia|https://en.wikipedia.org/wiki/Convolutional_neural_network>.
  Here we provide a simple strategy to generalize the usual discrete
  convolutional neural network to its continuous version. With this
  continuous version, we can show the qualitive fact (maybe general for all
  possible strategy of such generalization) that the convolutional neural
  network is non-local.

  <subsection|Convolutional Layer>

  Naturally, a convolutional layer can become continuous by convolution.
  Given two functions <math|f> and <math|g>, convolution is defined by

  <\equation*>
    <around*|(|f\<ast\>g|)><around*|(|x|)>\<assign\><big|int><rsub|\<bbb-R\><rsup|N>>\<mathd\>y
    f<around*|(|y|)> g<around*|(|x-y|)>.
  </equation*>

  In convolutional layer, filters can be described by a family of funcitons
  in Schwartz space, <math|<around*|{|f<rsub|i><around*|(|x|)>\|i\<in\>J|}>>.
  And the manipulation on input image, described by a scalar field
  <math|\<varphi\>>, by a convolutional layer is

  <\equation*>
    \<varphi\>\<rightarrow\><around*|{|f<rsub|i>\<ast\>\<varphi\>\|i\<in\>J|}>,
  </equation*>

  each element of which is a scalar field, or an image.

  <subsection|Pooling Layer>

  Pooling layer, if smooth, can be realized by smearing. So, given a
  smearning function <math|P> in Schwartz space, the manipulation on input
  image by a pooling layer is

  <\equation*>
    \<varphi\>\<rightarrow\>P\<ast\>\<varphi\>.
  </equation*>

  <subsection|Dense Layer>

  Finally, the dense layer deals with a set of images. For each image, the
  weight is described by a kernel <math|W<around*|(|x,y|)>>. So, the weight
  has three indices: the <math|x>, the <math|y>, and an index <math|i> for
  labelling image. So, the manipulation on input set of images by dense layer
  is

  <\equation*>
    <around*|{|\<varphi\><rsub|i>\|i\<in\>J|}>\<rightarrow\>\<sigma\><around*|(|<big|sum><rsub|i\<in\>J><big|int><rsub|\<bbb-R\><rsup|N>>\<mathd\>y
    W<rsub|i><around*|(|x,y|)> \<varphi\><rsub|i><around*|(|y|)>|)>,
  </equation*>

  where <math|\<sigma\>> is a given non-linear function, such as <math|tanh>
  or sigmoid function.

  <subsection|Convolutional Neural Network Is Non-Local>

  The total manipulation on the input image, or scalar field, can be seen as
  a functional. But, this functional is non-local, that is, it cannot be
  written as <math|<big|int><rsub|\<bbb-R\><rsup|N>>\<mathd\>x
  L<around*|(|\<varphi\><around*|(|x|)>,\<partial\>\<varphi\><around*|(|x|)>,\<partial\><rsup|2>\<varphi\><around*|(|x|)>,\<ldots\>|)>>
  for any function <math|L>. In convolutional neural network, lots of
  integrations are involved and nested, so that the final expression cannot
  be local.

  This means, if we use (continuous) convolutional neural network as the
  action functional, the renormalization group equation cannot be solved by
  local potential approximation, which demands that the action functional
  should be approximately local.
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|2>>
    <associate|auto-3|<tuple|2.1|2>>
    <associate|auto-4|<tuple|2.2|2>>
    <associate|auto-5|<tuple|2.3|2>>
    <associate|auto-6|<tuple|2.4|2>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnr-1|<tuple|1|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Boltzmann
      Machine Connects Self-Similarity and Renormalzation Group>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Convolutional
      Neural Network: Continuous Version>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Convolutional Layer
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Pooling Layer
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>Dense Layer
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>Convolutional Neural Network
      Is Non-Local <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>
    </associate>
  </collection>
</auxiliary>