### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 6ad2b2f6-01cf-4425-a45d-c59af164cd5f
using Statistics: mean

# ╔═╡ cf136e5f-e2e6-443f-820c-90633385e4e3
using ForwardDiff: derivative

# ╔═╡ 32f2fc05-d6c7-47b2-82d4-6fde3331dc29
using Optim: optimize, minimizer, converged

# ╔═╡ b2753165-501d-472c-8345-d3484c7f5bcd
using Plots, PlutoUI, LaTeXStrings

# ╔═╡ 9b25f3d7-b251-4300-9805-b0fb2fc8b7c5
using TaylorSeries: Taylor1, getcoeff

# ╔═╡ 610eae85-0573-44d8-b934-b9b3396e8bd5
using ForwardDiff: jacobian

# ╔═╡ 60d9287b-df42-4c7c-9d48-22cfaf39f68a
using LinearAlgebra: eigvals, eigvecs

# ╔═╡ 4381c01e-b9b8-11ed-26dd-63dd5f42ad3f
md"""
# Logistic Map and Renormalization Group

In this notebook, we study the universality of the (discrete) logistic map and derive a renormalization group equation from it.

## References:

1. [An introduction to universality and renormalization group techniques](https://arxiv.org/pdf/1210.2262.pdf).
2. [A simpler derivation of Feigenbaum’s renormalization group equation for the period-doubling bifurcation sequence](https://chaosbook.org/library/Copper98Feig.pdf).
3. [Universal behavior in nonlinear systems](https://cs.ioc.ee/~dima/mittelindyn/paper4.pdf), by Mitchell Feigenbaum.
4. Chaos and Nonlinear Dynamics, ISBN: 0198507232.
"""

# ╔═╡ 14db8687-8365-4d18-b7da-896ddb64fa58
md"""
## Iterative Map

A map $f: M \to M$, where $M$ is a subset of an Euclidean space, is called an *iterative map*. Starting at an arbitrarily given $x_0 \in M$, it generates an infinite series $(x_0, x_1, x_2, \ldots)$, with all elements in $M$, in the way that $x_{k+1} = f(x_k)$.
"""

# ╔═╡ b15a147c-0775-42b1-865a-db64fe46947e
function iterate(iter_fn, init, iter_steps)
    series = [init]
    x = init
    for step in 1:iter_steps
        x = iter_fn(x)
        push!(series, x)
	end
	series
end

# ╔═╡ b21c7143-8636-4b77-956e-67b2094f66d8
md"""

### Lyapunov Exponent

Starting at $x_0$, we fluctuate a little $y_0 = x_0 + \epsilon$, for $\forall \epsilon > 0$. Then at the $k$-th iteration, $\|y_k - x_k\| = \|f(y_{k-1}) - f(x_{k-1})\| = \|\partial f(x_{k-1})\| \|y_{k-1} - x_{k-1}\| + o(\epsilon)$. (Recall that the matrix norm is the [vector induced norm](https://en.wikipedia.org/wiki/Matrix_norm).) Again, the factor $y_{k-1} - x_{k-1}$ can be expressed in the same way, by replacing $k \to k-1$. By induction, we arrive at $\|y_k - x_k\| = \prod_{i=0}^{k-1} \|\partial f(x_i)\| \epsilon + o(\epsilon)$. Define *Lyapunov exponent* $\lambda$, by $\exp(k \lambda) \epsilon := \|y_k - x_k\|$. Then, up to $\mathcal{O}(\epsilon)$, we find $\lambda = (1/k) \sum_{i=0}^{k-1} \ln \|\partial f(x_i)\|$.

Notice that the $\lambda$ characterizes the evolution of tiny difference. When $\lambda > 0$, chaotic behaviour emerges, that is, the difference between $x_k$ and $y_k$ diverges exponentially fast as $k$ increase, no matter how small the initial difference $\epsilon$ is.
"""

# ╔═╡ 72aca014-32c1-421a-90fb-2cf368e764aa
function get_Lyapunov_exp(iter_fn, init, iter_steps)
    series = iterate(iter_fn, init, iter_steps)
    mean([log(abs(derivative(iter_fn, x))) for x in series])
end

# ╔═╡ 3270c71b-c5be-4a77-a270-08485d150a94
md"""
If the iterative map $f$ depands on extra paramters, e.g. $f_{\theta}$, we can compute $\lambda$ for all $\theta$; and plot the $\theta$-$\lambda$ diagram, that is, the *Lyapunov spectrum*.
"""

# ╔═╡ 4c77aff1-7f12-4225-a8ec-33132b3368e4
function get_Lyapunov_spectrum(iter_fn, params, init, iter_steps)
	[
		get_Lyapunov_exp(x -> iter_fn(θ, x), init, iter_steps)
	 	for θ in params
	]
end

# ╔═╡ 29fd9235-eab3-41bd-b922-f3ec5b31f836
md"""
### Coordinate Transformation and Gauge

Another important aspect for iterative map is coordinate transformation. That is, a diffeomorphism $z = \phi(x)$ that transforms from the original coordinate $x$ to the new $z$. The $z$ obeys the induced iterative relation $z_{k+1} = g(z_k)$ where $g := \phi \circ f \circ \phi^{-1}$.

So, the iterative map cannot uniquely determine the series. It's gauged, up to coordinate transform. Precisely, two iterative maps $f$ and $g$ generate intrinsically identitical series if there's a diffeomorphism $\phi$ such that $g = \phi \circ f \circ \phi^{-1}$.
"""

# ╔═╡ fd6c2087-c18a-4238-8798-cefd94007d18
md"""
### Fixed Point and Stability

For an iterative map $f$, a fixed point $x^*$ is the element in domain such that $x^* = f(x^*)$ holds.

Starting at the fixed point, we get a trivial iteration series $(x^*, x^*, \ldots)$. In this case, the Lyapunov exponent reduces to $\lambda = \ln \|\partial f (x^*)\|$. That is, the fixed point is stable if and only if $\|\partial f (x^*)\| < 1$.
"""

# ╔═╡ ffc720f0-7e7e-4baa-9604-fb2e3292c9f1
function find_fixed_point(f, init)
	loss(x) = sum(abs.(f(x) .- x))
	opt = optimize(loss, init)
	minimizer(opt), converged(opt)
end

# ╔═╡ 0851d9a0-7432-44c5-a81f-a7fc941601bd
md"""
## Logistic Map

The discrete logistic map is defined as $f_{\mu}(x) = \mu x (1-x)$ with $\mu \in [0, 4], x \in [0, 1]$; and $x_{n+1} = f_{\mu}(x_n)$ for $\forall n \in \mathbb{N}$.

However, as we will see in below, the "standard" form of logistic map $f_{\mu}(x) = 1 - \mu x^2$, where $\mu \in [0, 2], x \in [-1, 1]$, is more convenient. To convert to the "standard" form, a linear coordinate transform is sufficient, satisfying the conditions: the diffeomorphism $\phi: 0 \mapsto 1/2$ and the transformed iterative map $\phi \circ f_{\mu} \circ \phi^{-1}(0) = 1$. Remark that the $\phi$, which should depend on $\mu$, is not well-defined at $\mu = 2$, where $f_{\mu} (0) = 0$, since its parameters depends on $1 / (\mu - 2)$.
"""

# ╔═╡ 11c941cf-230b-4cc6-9ba9-e1fa800ff58b
function logistic(μ, x)
	1 - μ * x^2
end

# ╔═╡ b5f27652-523f-448d-89be-2c5b740d0e10
function plot_iterative_map(x, f, label)
	fig = plot()
	plot!(fig, x, f, label=label)
	plot!(fig, x, x, label="y = x"; linestyle=:dash)

	fixed_point = find_fixed_point(x -> f.(x), [0.])[1][1]
	df = derivative(f, fixed_point)
	vline!(fig, [fixed_point], label=L"f^{\prime}(x^*) = %$(df)"; linestyle=:dash)

	fig
end

# ╔═╡ 71789ebe-32b9-4101-b4c2-b3eb13cfabb5
md"""
### Period-Doubling Bifurcation

There's an infinite series $(\mu_0, \mu_1, \ldots) \in [0, \mu^*)$, where $\mu^* = 1.40109\cdots$. As $\mu$ increase from $0$ to $\mu^*$, stable orbit doubles its period every time $\mu$ crosses an element in the series.

As $\mu \to \mu^*$, a *critical point*, the stable orbit doubles its period infinite times so that it runs over the domain $[-1, 1]$. At this stage, the iteraion goes into chaos.
"""

# ╔═╡ 57886f5f-ce85-4e87-a182-afa323b8b224
md"""
This can be shown via Lyapunov spectrum:
"""

# ╔═╡ d3ac3ba8-e201-42ac-9444-9e1498ff6154
function plot_Lyapunov_specturm(f, θ, init, critical_point)
	spec = get_Lyapunov_spectrum(f, θ, init, 2000)
	fig = plot()
	plot!(fig, θ, spec, label="Lyapunov Spectrum")
	hline!(fig, [0.], label="Zero", linestyle=:dash)
	vline!(fig, [critical_point], label="Critical Point", linestyle=:dash)
end

# ╔═╡ f863bf94-aa00-4130-854e-276f78aebdba
plot_Lyapunov_specturm(logistic, LinRange(0, 2, 5000), 0.1, 1.40109)

# ╔═╡ 6a00ad7b-86b0-453f-be8e-350783973424
md"""
Now, we investigate how the period-doubling bifurcation happens.

As the $\mu$ increases, the slope of $f_{\mu}$ becomes greater and greater, until the $|f_{\mu}^{\prime}|$ at the fixed point becomes greater than $1$, so that the fixed point turns to be unstable.

However, the fixed point of $f_{\mu} \circ f_{\mu}$ is still stable, let it be $x_0$. This means the "2-circle" $x_1 = f_{\mu}(x_0), x_0 = f_{\mu}(x_1)$ is stable. And for any $x$ near $x_0$, the series will stablize to it.

As we further increase the $\mu$, based on the same process, we get 4-circle, 8-circle, 16-circle, etc.
"""

# ╔═╡ 75c10caa-c0ad-441a-ab30-e5d9f4c2bde9
md"""
## Renormalization Group and Self-similarity

### Derive a Renormalization Group from Logistic Map

To quantitively describe this process, we need to study the composition process. Let's start at composition once, that is, $(f_{\mu} \circ f_{\mu})$.

First, we plot the $(f_{\mu} \circ f_{\mu}) (x)$ for $x \in [-1, 1]$:
"""

# ╔═╡ 2ac385c9-b8d8-40e9-8f65-b72e3c0bfb3e
@bind μ Slider(LinRange(0.7, 1.5, 100))

# ╔═╡ 3361f969-b02e-431c-bde9-7439ff8b8e3e
plot_iterative_map(LinRange(-1, 1, 1000), x -> logistic(μ, x), "Logistic Map")

# ╔═╡ 91e3aaff-e724-40f8-82b0-be20ea2ee6e0
plot_iterative_map(LinRange(-1, 1, 1000), x -> logistic(μ, logistic(μ, x)), L"$f^2_{\mu}$")

# ╔═╡ 3af50850-50c3-44f0-a091-41501465b97a
plot_iterative_map(LinRange(-1, 1, 1000), x -> logistic(μ, x), L"f_{\mu}")

# ╔═╡ 8e42d108-fd41-4577-941e-7f9e4ca04b5a
md"""
We find that, around $x = 0$, the local shape looks like the original $f$. Indeed, if we zoom in (and flip) by a factor $-1 / \alpha$, where $\alpha > 1$, to the original scale, we will get the function with the same type of shape. By saying the orignal scale, we mean that $g_{\mu}(0) = 1$ with $g_{\mu}(x) := -\alpha (f_{\mu} \circ f_{\mu}) (x / (-\alpha))$, since $f_{\mu}(0) = 1$. This means the $\alpha = -1 / (f \circ f) (0)$.
"""

# ╔═╡ 5f0d985e-92a7-4e5f-9a3f-9253a4b610f7
get_α(f) = -1 / f(f(0))

# ╔═╡ 2fd5f807-8a52-4964-b62f-55f18e469d73
function display_zoom_in(μ)
	f = x -> logistic(μ, x)
	α = get_α(f)
	g(x) = -α * (f ∘ f)(-x / α)
	plot_iterative_map(LinRange(-1, 1, 1000), g, "Zoom-in")
end

# ╔═╡ e5284414-3f31-4edc-84cc-a0869728bdda
display_zoom_in(μ)

# ╔═╡ debc320f-15db-484a-969b-9336398e7d1b
md"""
The difference is that, $g_{\mu}$ is flatter than $f_{\mu}$. This is plausible for period-doubling bifurcation arising.

Remark that zoom-in does not change the shape of the curve. So, the fixed point and its stability is invariant under zoom-in. That is, to study the fixed point of $f_{\mu} \circ f_{\mu}$, that is 2-circle, we can equivalently study that of $g_{\mu}$.

Then, we continue increasing the $\mu$, rather than on $f_{\mu}$, but on $g_{\mu}$, the slope of which becomes greater and greater. Again, at some value, the fixed point of $g_{\mu}$ becomes unstable, meaning that a 4-circle appears.

This process is recursive. And now, we can define $h_{\mu}(x) := -\alpha (g_{\mu} \circ g_{\mu}) (x / (-\alpha))$, by which we study the 4-circle with the same process as before. (Notice that the $\alpha$ herein is a functional of $g_{\mu}$.)

Now we come to the critical step. The previous analysis hints us to change the object of investigation from the logistic map to the generic process that generates period-doubling bifurcation. This is the basic idea of *renormalization group*. To do so, define the operator

$$\hat{R}: C(\mathbb{R}) \to C(\mathbb{R}),$$

$$\hat{R}(f)(x) := -\alpha (f \circ f) (x / (-\alpha)),$$

where $\alpha$ is a functional of $f$. We can recursively obtain the $\hat{R}^n(f_{\mu})$, by which we study the $2^n$-circle.

This operator, by which the same process can be simply repeated onto higher circles, is called *renormalization group operator* (RGO).
"""

# ╔═╡ 5f8081d4-552c-460e-baa1-a09c323857a5
function R̂(f)
	α = get_α(f)
	x -> -α * f(f(-x / α))
end

# ╔═╡ 27d36903-fe82-4188-b353-9140aa3280fb
md"""
Let's visualize the $f_{\mu}$, $\hat{R}(f_{\mu})$, $\hat{R}^2(f_{\mu})$, etc.
"""

# ╔═╡ d5228648-6010-4058-899e-979cc32a620b
function R̂(n, f)
	if n == 0
		f
	else
		R̂(R̂(n-1, f))
	end
end

# ╔═╡ 59d33908-eff5-435a-b1aa-f618c81c19ce
plot_iterative_map(LinRange(-1, 1, 1000), R̂(0, x -> logistic(μ, x)), L"$f_{\mu}$")

# ╔═╡ b537779b-ef5d-4525-a90a-af44be412c89
plot_iterative_map(LinRange(-1, 1, 1000), R̂(1, x -> logistic(μ, x)), L"$R(f_{\mu})$")

# ╔═╡ ea347cd7-f818-4645-a4cc-1018dfd6afde
plot_iterative_map(LinRange(-1, 1, 1000), R̂(2, x -> logistic(μ, x)), L"$R^2(f_{\mu})$")

# ╔═╡ cc003e7a-e1fa-43ce-b965-f3733b8a7e7d
plot_iterative_map(LinRange(-1, 1, 1000), R̂(3, x -> logistic(μ, x)), L"$R^3(f_{\mu})$")

# ╔═╡ 1084b6c7-882d-45a5-a5c2-e9b0277d9a5f
md"""
### Truncation of Space

However, the domain of the renormalization group operator is the whole function space $C(\mathbb{R})$, which is untractable. For instance, even though lookes like $f_{\mu}$, the expression of $\hat{R}(f_{\mu})$ is much more complicated. As $n$ increases, the expression of $\hat{R}^n(f_{\mu})$ contains so many terms that the investigation becomes frustrating。

The strategy to solve the problem is called *local potential approximation*, first proposed by Physicists. The basic idea is to truncate the whole function space to its subspace, which has finite dimension, ensuring that the loss is negligible.

Explicitly, we truncate the whole function space to the subspace generated by Taylor series up to $N$-order, which is valid at least for $x$ in a neighbourhood of $0$. In addition, we shall have $f(0) = 1$ to keep the scale. Since the logistic map is parity symmetric, we shall restrict the function space to that with parity symmetry too. So, an element of the subspace can be represented by $1 + c_1 x^2 + c_2 x^4 + \cdots + c_N x^{2N}$. It's $\mathbb{R}^N$ with coordinate $c = (c_1, \ldots, c_N)$. Now, the complicated functional iteration becomes an iteration on simple Euclidean space. That is,

$$\hat{R}_t: \mathbb{R}^N \to \mathbb{R}^N,$$

where the subscript "t" hints for "truncated".
"""

# ╔═╡ bd3a8de9-63c9-42f5-ba87-9c6b68fad116
function get_f(c)
	function f(x)
		result = one(x)  # c₀ = 1.
		power = x^2
		for cᵢ in c  # c₁, c₂, ...
			result += cᵢ * power
			power *= x^2
		end
		result
	end
end

# ╔═╡ 8b4c382d-97fc-422a-a690-ff9d2c886f5e
function R̂ₜ(c)
	f = get_f(c)
	α = get_α(f)
	next_f(x) = -α * f(f(-x / α))

	N = length(c)
	x = Taylor1(Float64, 2N)
	[getcoeff(next_f(x), 2n) for n = 1:N]
end

# ╔═╡ cba518b1-7ed0-421d-8eeb-539e0b41b180
md"""
### Fixed Point of RGO

Now, we investigate the fixed point of $\hat{R}$ on the truncated space.

When solving fixed point, initial value is very critical. Our strategy is by iteration. Explicitly, we first let $N = 1$, that is, $f(x) = 1 + c_1 x^2$. After solving the $c_1$ by a given initial value, we set the $N = 2$ with the initial value of $c_1$ the ones just obtained. The initial value of $c_2$ is given. This process iterates again and again, until the $c_N$ where the $N$ is either given or the one the searching of fixed point failed. In the later case, the $c_N$-term is excluded from the result.
"""

# ╔═╡ 91e40b01-ef12-4740-acfa-efa7d73b958c
function iter_solve(solver, init)
	x = eltype(init)[]
	N = length(init)
	for i = 1:N
		push!(x, init[i])
		new_x, success = solver(x)
		if success == false
			println("Failed at step $(i).")
			break
		else
			x = new_x
		end
	end
	x
end

# ╔═╡ 2d14c1ff-8ea6-45a9-b392-35f1fba82337
md"""
Now, we solve the fixed point at each iterative step by optimization method.
"""

# ╔═╡ 5ee5fc11-257f-420a-a22a-740d6d584fbb
RG_solver(init) = find_fixed_point(R̂ₜ, init)

# ╔═╡ 355fd36f-c41f-442a-89d6-4064fd4c6a91
md"""
For the given initial values, we set $c_1 = -1.2$ and the rests vanish, corresponding to $\mu = 1.2$ in the logistic map.
"""

# ╔═╡ 65a6fa8c-8c70-4390-a98e-8d1921bde604
fixed_point = iter_solve(RG_solver, [-1.2, 0., 0., 0., 0.])

# ╔═╡ 8e214be9-5218-4378-9b7f-f0151c5c8510
R̂ₜ([-1.4, 0.])

# ╔═╡ be38e5e4-9a68-42b7-9351-300dc1c83fcc
md"""
With the $c$ converges to the fixed point, so is the $\alpha$, which is a function of $c$.
"""

# ╔═╡ b9cd501d-948f-47d4-8e94-119f42be23bc
get_α(get_f(fixed_point))

# ╔═╡ 048580b6-8bbc-46fd-9d29-6e923aba4739
md"""
This result is consistent with that given by ref[4], appendix F.

For other given initial value of $c$, the result is different. And the $\alpha$ at the fixed point can be smaller than $1$ which is invalid and should be excluded.
"""

# ╔═╡ f6b1c5dd-1c03-4e4e-8080-fbaf75f6e1b7
md"""
### Stability of the Fixed Point

Since $\hat{R}$ is again an iterative map after truncation, we can study its stability at the fixed point by the method previously stated. We employ $L_2$-norm. In this case, the induced matrix norm is $\|\partial f(x^*)\| = |\lambda_{\text{max}}|$, where $\lambda_{\text{max}}$ is the maximum of the eigen-values of the Jacobian matrix $\partial f(x^*)$.
"""

# ╔═╡ 296ff34f-4e59-44c9-a33d-87819a413180
function get_eigen_system(f, fixed_point)
	jacob = jacobian(f, fixed_point)
	vals = eigvals(jacob)
	vecs = eigvecs(jacob)

	result = []
	for i = 1:length(vals)
		push!(result, [vals[i], vecs[:, i]])
	end
	result
end

# ╔═╡ b264e376-71a5-4854-9e7b-f190d9523a75
get_eigen_system(R̂ₜ, fixed_point)

# ╔═╡ 5c8a72df-aa32-4d93-8819-01f8845b6832
md"""
We find that the eigen-system is dominated by the eigen-value, denoted by $\delta$, about $4.7$. So the fixed point is unstable. Interestingly, this value is consistent with ref[1]. But the computation there is much more complicated and unsafe (with strange ansatz).
"""

# ╔═╡ b1ff8592-f5df-4b16-aaaf-f4b398f65ea1
md"""
### Self-similarity

The result is that the logistic map at critical point, $f_{\mu^*}$, has $\hat{R}(f_{\mu^*}) \approx f_{\mu^*}$. But I don't know why.
"""

# ╔═╡ ae60a720-bb63-43f6-9282-7c8f271334b2
plot_iterative_map(LinRange(-1, 1, 1000), x -> logistic(1.40109, x), L"$f_{\mu^*}$")

# ╔═╡ ab316a00-4cfd-499b-9cdd-992630b75810
md"""
### Meaning of $\delta$

This eigen-value has realistic meanings. To illustrate this, we shall first define the *superstable* $\mu$ of $f_{\mu}^{2^n}$, denoted by $\tilde{\mu}_n$, which is the $\mu$ such that $f_{\mu}^{2^n}(0) = 0$. In this case, $0$ is a fixed point.

Now, we consider $\hat{R}(f_{\tilde{\mu}_n})$. Expand it at the critical point $f_{\mu^*}$, where $f_{\tilde{\mu}_n} \approx f_{\mu^*} + \partial_{\mu} f_{\mu^*} (\tilde{\mu}_n - \mu^*)$ we have $\hat{R}(f_{\tilde{\mu}_n}) \approx \hat{R}(f_{\mu^*}) + \hat{R}^{\prime}(f_{\mu^*}) \partial_{\mu} f_{\mu^*} (\tilde{\mu}_n - \mu^*)$。 Projecting into the truncated function space, $\partial_{\mu} f_{\mu^*} = g \varphi + \cdots$, where $\varphi$ is the eigen-vector corresponding to $\delta$ and $g$ the coefficient. Suppose that the other terms are negligible. we will have $\hat{R}^{\prime}(f_{\mu^*}) \partial_{\mu} f_{\mu^*} \approx g \delta \varphi$. Also by self-similarity, $\hat{R}(f_{\mu^*}) \approx f_{\mu^*}$. So, we have

$$\hat{R}(f_{\tilde{\mu}_n}) \approx f_{\mu^*} + g \delta \varphi (\tilde{\mu}_n - \mu^*).$$

Repeating this process, we will find $\hat{R}^n(f_{\tilde{\mu}_n}) \approx f_{\mu^*} + g \delta^n \varphi (\tilde{\mu}_n - \mu^*).$ At $x = 0$, since $\tilde{\mu}_n$ is superstable and $f_{\mu^*}(0) = 1$, we get $0 = 1 + g \delta^n \varphi(0) (\tilde{\mu}_n - \mu^*)$. That is, $(\tilde{\mu}_n - \mu^*) \delta^n = -1 / (g \varphi(0)) = \text{const}$. So, the dominate eigen-value $\delta$ describes the convergence rate of superstable $\tilde{\mu}_n$.
"""

# ╔═╡ b92951c1-8292-4397-9fb9-60b59cfa4a98
md"""
## Universality

Notice that the previous analysis is quite general, regardless of the explicit expression of the logistic map. This means that it holds for a large number of instances where the period-doubling bifurcation emerge. So, the fixed point solution, the $\alpha$ value, and the eigen-values at the fixed point (especially the $\delta$ value), are universal for all these instances, even though the underlying physical process is completely different!

A famous instance is the turbulence, where, as the flux increases to the critical point, the same self-similar $\alpha$ emerges! We can predict the iterative series without knowing the underlying physics (Navier-Stokes equation)!
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Optim = "429524aa-4258-5aef-a3af-852621145aeb"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
TaylorSeries = "6aa5eb33-94cf-58f4-a9d0-e4b2c4fc25ea"

[compat]
ForwardDiff = "~0.10.35"
LaTeXStrings = "~1.3.0"
Optim = "~1.7.4"
Plots = "~1.38.6"
PlutoUI = "~0.7.50"
TaylorSeries = "~0.13.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "8a9749a93a67eed5a2e8184abeee2b241c4e2917"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "cc37d689f599e8df4f464b2fa3870ff7db7492ef"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.6.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SnoopPrecompile", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "ec9c36854b569323551a6faf2f31fda15e3459a7"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c6d890a52d2c4d55d326439580c3b8d0875a77d9"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.7"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "485193efd2176b88e6622a39a246f8c5b600e74e"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "61fdd77467a5c3ad071ef8277ac6bd6af7dd4c04"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "89a9db8d28102b094992472d333674bd1a83ce2a"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "a4ad7ef19d2cdc2eff57abbbe68032b1cd0bd8f8"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.13.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "d3ba08ab64bdfd27234d3f61956c966266757fe6"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.7"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Requires", "Setfield", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "ed1b56934a2f7a65035976985da71b6a65b4f2cf"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.18.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "00e252f4d706b3d55a8863432e742bf5717b498d"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.35"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "660b2ea2ec2b010bb02823c6d0ff6afd9bdc5c16"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.71.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d5e1fd17ac7f3aa4c5287a61ee28d4f8b8e98873"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.71.7+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "37e4657cd56b11abe3d10cd4a1ec5fbdb4180263"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.7.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "Printf"]
git-tree-sha1 = "7bbea35cec17305fc70a0e5b4641477dc0789d9d"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.2.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "6503b77492fd7fcb9379bf73cd31035670e3c509"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Optim]]
deps = ["Compat", "FillArrays", "ForwardDiff", "LineSearches", "LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "PositiveFactorizations", "Printf", "SparseArrays", "StatsBase"]
git-tree-sha1 = "1903afc76b7d01719d9c30d3c7d501b61db96721"
uuid = "429524aa-4258-5aef-a3af-852621145aeb"
version = "1.7.4"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6f4fbcd1ad45905a5dee3f4256fabb49aa2110c6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.7"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "c95373e73290cf50a8a22c3375e4625ded5c5280"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "da1d3fb7183e38603fcdd2061c47979d91202c97"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.PositiveFactorizations]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "17275485f373e6673f7e7f97051f703ed5b15b20"
uuid = "85a6dd25-e78a-55b7-8502-1745935b8125"
version = "0.2.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "261dddd3b862bd2c940cf6ca4d1c8fe593e457c8"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.3"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase", "SnoopPrecompile"]
git-tree-sha1 = "e974477be88cb5e3040009f3767611bc6357846f"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.11"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "2d7d9e1ddadc8407ffd460e24218e37ef52dd9a3"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.16"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TaylorSeries]]
deps = ["LinearAlgebra", "Markdown", "Requires", "SparseArrays"]
git-tree-sha1 = "31834a05c8a9d52d7f56b23ae7ad1c3b72a4f1bf"
uuid = "6aa5eb33-94cf-58f4-a9d0-e4b2c4fc25ea"
version = "0.13.2"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "94f38103c984f89cf77c402f2a68dbd870f8165f"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.11"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6edfe154ad7b313c01aceca188c05c835c67360"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.4+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─4381c01e-b9b8-11ed-26dd-63dd5f42ad3f
# ╠═14db8687-8365-4d18-b7da-896ddb64fa58
# ╠═b15a147c-0775-42b1-865a-db64fe46947e
# ╟─b21c7143-8636-4b77-956e-67b2094f66d8
# ╠═6ad2b2f6-01cf-4425-a45d-c59af164cd5f
# ╠═cf136e5f-e2e6-443f-820c-90633385e4e3
# ╠═72aca014-32c1-421a-90fb-2cf368e764aa
# ╟─3270c71b-c5be-4a77-a270-08485d150a94
# ╠═4c77aff1-7f12-4225-a8ec-33132b3368e4
# ╟─29fd9235-eab3-41bd-b922-f3ec5b31f836
# ╟─fd6c2087-c18a-4238-8798-cefd94007d18
# ╠═32f2fc05-d6c7-47b2-82d4-6fde3331dc29
# ╠═ffc720f0-7e7e-4baa-9604-fb2e3292c9f1
# ╟─0851d9a0-7432-44c5-a81f-a7fc941601bd
# ╠═11c941cf-230b-4cc6-9ba9-e1fa800ff58b
# ╠═b2753165-501d-472c-8345-d3484c7f5bcd
# ╠═b5f27652-523f-448d-89be-2c5b740d0e10
# ╠═b1cde196-2cbb-47e4-9582-9b998207205f
# ╟─3361f969-b02e-431c-bde9-7439ff8b8e3e
# ╟─71789ebe-32b9-4101-b4c2-b3eb13cfabb5
# ╟─57886f5f-ce85-4e87-a182-afa323b8b224
# ╟─d3ac3ba8-e201-42ac-9444-9e1498ff6154
# ╟─f863bf94-aa00-4130-854e-276f78aebdba
# ╟─6a00ad7b-86b0-453f-be8e-350783973424
# ╟─75c10caa-c0ad-441a-ab30-e5d9f4c2bde9
# ╠═2ac385c9-b8d8-40e9-8f65-b72e3c0bfb3e
# ╠═91e3aaff-e724-40f8-82b0-be20ea2ee6e0
# ╠═3af50850-50c3-44f0-a091-41501465b97a
# ╟─8e42d108-fd41-4577-941e-7f9e4ca04b5a
# ╠═5f0d985e-92a7-4e5f-9a3f-9253a4b610f7
# ╠═2fd5f807-8a52-4964-b62f-55f18e469d73
# ╠═9d58464c-1876-4b3c-a0af-c42033d8e862
# ╟─e5284414-3f31-4edc-84cc-a0869728bdda
# ╟─debc320f-15db-484a-969b-9336398e7d1b
# ╠═5f8081d4-552c-460e-baa1-a09c323857a5
# ╟─27d36903-fe82-4188-b353-9140aa3280fb
# ╠═d5228648-6010-4058-899e-979cc32a620b
# ╠═cc77c616-7b12-4a71-958e-f3eea0bf5df0
# ╠═59d33908-eff5-435a-b1aa-f618c81c19ce
# ╠═b537779b-ef5d-4525-a90a-af44be412c89
# ╠═ea347cd7-f818-4645-a4cc-1018dfd6afde
# ╠═cc003e7a-e1fa-43ce-b965-f3733b8a7e7d
# ╟─1084b6c7-882d-45a5-a5c2-e9b0277d9a5f
# ╠═bd3a8de9-63c9-42f5-ba87-9c6b68fad116
# ╠═9b25f3d7-b251-4300-9805-b0fb2fc8b7c5
# ╠═8b4c382d-97fc-422a-a690-ff9d2c886f5e
# ╟─cba518b1-7ed0-421d-8eeb-539e0b41b180
# ╠═91e40b01-ef12-4740-acfa-efa7d73b958c
# ╟─2d14c1ff-8ea6-45a9-b392-35f1fba82337
# ╠═5ee5fc11-257f-420a-a22a-740d6d584fbb
# ╟─355fd36f-c41f-442a-89d6-4064fd4c6a91
# ╠═65a6fa8c-8c70-4390-a98e-8d1921bde604
# ╠═8e214be9-5218-4378-9b7f-f0151c5c8510
# ╟─be38e5e4-9a68-42b7-9351-300dc1c83fcc
# ╠═b9cd501d-948f-47d4-8e94-119f42be23bc
# ╟─048580b6-8bbc-46fd-9d29-6e923aba4739
# ╟─f6b1c5dd-1c03-4e4e-8080-fbaf75f6e1b7
# ╠═610eae85-0573-44d8-b934-b9b3396e8bd5
# ╠═60d9287b-df42-4c7c-9d48-22cfaf39f68a
# ╠═296ff34f-4e59-44c9-a33d-87819a413180
# ╠═b264e376-71a5-4854-9e7b-f190d9523a75
# ╟─5c8a72df-aa32-4d93-8819-01f8845b6832
# ╟─b1ff8592-f5df-4b16-aaaf-f4b398f65ea1
# ╠═ae60a720-bb63-43f6-9282-7c8f271334b2
# ╟─ab316a00-4cfd-499b-9cdd-992630b75810
# ╟─b92951c1-8292-4397-9fb9-60b59cfa4a98
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
