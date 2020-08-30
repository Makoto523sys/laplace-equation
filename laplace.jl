using Printf;
using Plots;

function init()
	## 横の長さ
	global lx = 1.0;
	## 縦の長さ
	global ly = 1.0;
	## 横の分割数
	global nx = 11;
	## 縦の分割数
	global ny = 11;
	global dx = lx / (nx - 1);
	global dy = ly / (ny - 1);
	## 係数
	beta_x = 1.0 / dx^2;
	beta_y = 1.0 / dy^2;
	global x = range(0.0, stop=lx, length=nx);
	global y = range(0.0, stop=ly, length=ny);
	global u = zeros(Float64, (ny, nx));
	## 境界条件の適用
	u[:, begin] .= 0.0;
	u[:, end] = 100y;
	u[begin, :] .= 0.0;
	u[end, :] = 100x;
	global u_t = zeros(Float64, (ny, nx));
	for j = 1:ny
		for i = 1:nx
			u_t[j, i] = 100*x[i]*y[j];
		end
	end
	global pre_u = copy(u);
	## SOR法のωの値を決定
	mu = cos(pi/nx) + cos(pi/ny);
	global omega = 2.0/(1.0 + sqrt(1-(mu/2)^2));
	global epsilon = 2e-4;
	global a_ir = beta_x;
	global a_il = beta_x;
	global a_ia = beta_y;
	global a_ib = beta_y;
	global a_0 = -2.0(beta_x + beta_y);
	global rhs = 0.0;
	global iter_max = 100;
	global epsilon = 2e-4;
end

function main()
	init();
	for iter=1:iter_max
		err = 0.0;
		for j = 1:ny-2
			for i = 1:nx-2
				tmp = (rhs - a_ir*u[j+1, i+2] - a_il*u[j+1, i] - a_ia*u[j+2, i+1] - a_ib*u[j, i+1]) / a_0;
				u[j+1, i+1] = u[j+1, i+1] + (tmp - u[j+1, i+1])*omega;;
				err += sqrt((u_t[j+1, i+1] - u[j+1, i+1])^2)/(nx*ny);
			end
		end
		err = sqrt(sum((u - u_t).^2)/(nx*ny))
		#err = sqrt(sum((u - pre_u).^2)/(nx*ny)) global pre_u = copy(u);
		@printf("iter: %d, err: %5e\n", iter, err);
		if err < epsilon
			break;
		end
	end
	contour(u);
	savefig("Laplace.png");
end

main()
