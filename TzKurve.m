% 11.45, 6.55 vn Hsn
% 29.95, 11.25 vw50 Hsvw50
% 27.35, 14.65 vHs50 Hs50

v =  [11.45, 29.95, 27.35];
hs = [6.55,  11.25, 14.65];
gamma = 3.3;

tzFunction = 'c1 + c2 * sqrt(x / 9.81)';                %A.F. Haselsteiner; 2020; OMAE2020-8219; GLOBAL HIERARCHICAL MODELS FOR WIND AND WAVE CONTOURS: PHYSICAL INTERPRETATIONS OF THE DEPENDENCE FUNCTIONS
fo2p = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0, 0],...
               'Upper',[Inf, Inf],...
               'StartPoint',[1 1]);
load DEF_with_3_variables.mat                           %A.F.Haselsteiner

figure
 plot(D.Hs, D.Tz, '.k')
 hold on
 xlabel('significant wave height (m)');
 ylabel('zero-up-crossing period (s)');
 
 
 intervalCenter = [0.25 : 0.5 : 9.75];
bin_width = 0.5;
hs_lower = intervalCenter - 0.5 * bin_width;
hs_upper = intervalCenter + 0.5 * bin_width;

is_in_bin = zeros(length(D.Tz), 3);
is_greater = zeros(length(D.Tz), 3);
is_less = zeros(length(D.Tz), 3);
for i = 1:length(intervalCenter) 
    is_greater(:, i) = D.Hs > hs_lower(i);
    is_less(:, i) = D.Hs < hs_upper(i);
    is_in_bin = logical(is_greater .* is_less);
    hs_in_interval{i} = D.Hs(is_in_bin(:, i));
    tz_in_interval{i} = D.Tz(is_in_bin(:, i));
    hs_mean(i) = mean(hs_in_interval{i});
    tz_mean(i) = mean(tz_in_interval{i});
end


fTz = fit(hs_mean', tz_mean', tzFunction, fo2p);
plot(hs_mean, tz_mean, 'xr','linewidth',2);
temp = [0: 0.1: 15];
plot(temp, fTz(temp), 'r', 'linewidth',1.5);
plot(hs, fTz(hs), 'bd','MarkerFaceColor','b');
eqString = [num2str(fTz.c1, '%.3f') ' + ' num2str(fTz.c2, '%.1f') ' * sqrt(hs / g)'];
legend({'observation', 'average of observations per interval', eqString, 'estimated t_z value'}, 'location', 'southeast')
legend box off
xlabel('significant wave height (m)');
ylabel('zero-up-crossing period (s)');
box off

Tz1 = [fTz(hs(1))];
num2str(Tz1, '%.2f');
Tp1 =(1.49-0.102*gamma+0.0142*gamma^2-0.00079*gamma^3)*Tz1;
num2str(Tp1, '%.2f')

Tz2 = [fTz(hs(2))];
num2str(Tz2, '%.2f');
Tp2 =(1.49-0.102*gamma+0.0142*gamma^2-0.00079*gamma^3)*Tz2;
num2str(Tp2, '%.2f')

Tz3 = [fTz(hs(3))];
num2str(Tz3, '%.2f');
Tp3 =(1.49-0.102*gamma+0.0142*gamma^2-0.00079*gamma^3)*Tz3;
num2str(Tp3, '%.2f')