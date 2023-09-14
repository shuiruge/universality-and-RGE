<TeXmacs|2.1>

<style|generic>

<\body>
  <section|Boltzmann Machine Connects Self-Similarity and Renormalzation
  Group>

  <subsection|The Basic Idea>

  There are many kinds of self-similarity in Nature. Turbulence, for
  instance, has self-similarity at the critical point of parameters. This
  self-similarity indicates that, when you zoom-in a picture of turbulence,
  you should find that the original consists of many smaller turbulence each
  of which looks quite like the original. By saying \Plooks like\Q, we mean
  they share the same \Ppattern\Q. That is, <with|font-shape|italic|they are
  not exactly the same, but same in pattern, which is recognized by our
  brain.>

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

  <subsection|Renormalization Group Equation>

  We can continuously marginalize the region between <math|V> and <math|A>.
  Explicitly, let <math|t\<in\><around*|[|0,1|]>> as a continuous parameter.
  Consider a continuously changed region <math|A<rprime|'><around*|(|t|)>>,
  so that <math|A<rprime|'><around*|(|0|)>=V> and
  <math|A<rprime|'><around*|(|1|)>=A>, and that
  <math|A<rprime|'><around*|(|t<rsub|1>|)>\<subset\>A<rprime|'><around*|(|t<rsub|0>|)>>
  as long as <math|t<rsub|1>\<gtr\>t<rsub|0>>. <math|>This makes the
  effective action function <math|S<rsub|A<rprime|'>>> continuously change
  from <math|S> to <math|S<rsub|A>>, depending on <math|t>. This gives birth
  to a renormalization group equation, which is a functional autonomous
  differential equation, of <math|\<mathd\>S<rsub|A<rprime|'>>/\<mathd\>t>.

  How is self-similarity characterized by this renormalization group
  equation? An educated guess is that self-similarity is a limit circle of
  this autonomous differential equation. It starts at a point and travels
  along a circle. Finally it goes back to the starting point: the
  self-similarity. And then, it starts the same trip again.

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
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|3.3|?>>
    <associate|auto-11|<tuple|3.4|?>>
    <associate|auto-12|<tuple|3.5|?>>
    <associate|auto-2|<tuple|1.1|2>>
    <associate|auto-3|<tuple|1.2|2>>
    <associate|auto-4|<tuple|1.3|2>>
    <associate|auto-5|<tuple|2|2>>
    <associate|auto-6|<tuple|2.1|3>>
    <associate|auto-7|<tuple|3|3>>
    <associate|auto-8|<tuple|3.1|3>>
    <associate|auto-9|<tuple|3.2|3>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-2|<tuple|2|2>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-2|<tuple|2|2>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Boltzmann
      Machine Connects Self-Similarity and Renormalzation Group>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Vanilla Boltzmann Machine
      with Locality <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Continuous Symmetries
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Convolutional
      Neural Network: Continuous Version>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <with|par-left|<quote|1tab>|3.1<space|2spc>Convolutional Layer
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>Pooling Layer
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1tab>|3.3<space|2spc>Dense Layer
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <with|par-left|<quote|1tab>|3.4<space|2spc>Convolutional Neural Network
      Is Non-Local <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>
    </associate>
  </collection>
</auxiliary>