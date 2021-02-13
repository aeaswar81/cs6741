### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ cf44c9de-6d52-11eb-04f4-792ab37a9ba2
using Random

# ╔═╡ ac19d482-6d54-11eb-323d-b9514970d099
Rand.seed!(1)

# ╔═╡ 1961dac8-6d55-11eb-157b-17566660a80b
rand(2)

# ╔═╡ 14a4841c-6d53-11eb-002d-4fa5fb520ec3
begin
	N=1000
	su=0
	for _ in 1:N
		su=su+rand(Int)
	end
end

# ╔═╡ 6f5f9e9e-6d53-11eb-38eb-c78b3aee1737
su/N

# ╔═╡ 20128314-6d54-11eb-0b64-73562032a18c
begin
	array=rand(Int,1000)
	s=sum(array)
end

# ╔═╡ 81ff6614-6d54-11eb-2121-6bbd7b5e29dc
s/1000

# ╔═╡ Cell order:
# ╠═cf44c9de-6d52-11eb-04f4-792ab37a9ba2
# ╠═ac19d482-6d54-11eb-323d-b9514970d099
# ╠═1961dac8-6d55-11eb-157b-17566660a80b
# ╠═14a4841c-6d53-11eb-002d-4fa5fb520ec3
# ╠═6f5f9e9e-6d53-11eb-38eb-c78b3aee1737
# ╠═20128314-6d54-11eb-0b64-73562032a18c
# ╠═81ff6614-6d54-11eb-2121-6bbd7b5e29dc
