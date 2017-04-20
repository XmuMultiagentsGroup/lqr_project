%plots
close all

% %___SYSTEM OUTPUT PLOTS___
% figure(1)
% plot(h_desired.time, h_desired.signals.values,'-.',h_output.time, h_output.signals.values)
% title('LQR Full Observed State Feedback (height displacement)')
% xlabel('time (s)')
% ylabel('height (m)')
% legend('h reference', 'h')
% axis([0, 200, -1, 7])
% 
% figure(2)
% plot(z_desired.time, z_desired.signals.values,'-.',z_output.time, z_output.signals.values)
% title('LQR Full Observed State Feedback (horizontal displacement)')
% xlabel('time (s)')
% ylabel('horizontal position, z (m)')
% legend('z reference', 'z')
% axis([0, 200, -1, 7])


%___STATE ESTIMATE PLOTS___
figure(1)
subplot(3,2,1)
plot(xhat_state.time, xhat_state.signals.values(:,1),x_state.time, x_state.signals.values(:,1),'-.')
str1 = {'$ \hat{z} $ vs $ z $'};
title(str1, 'Interpreter','latex')
str2 = {'$ z $ (m)'};
ylabel(str2, 'Interpreter','latex')
axis([0, 100, -1, 7])

subplot(3,2,3)
plot(xhat_state.time, xhat_state.signals.values(:,2),x_state.time, x_state.signals.values(:,2),'-.')
str1 = {'$ \hat{\theta} $ vs $ \theta $'};
title(str1, 'Interpreter','latex')
str2 = {'$ \theta $ (rad)'};
ylabel(str2, 'Interpreter','latex')
axis([0, 100, -0.7, 0.7])

subplot(3,2,5)
plot(xhat_state.time, xhat_state.signals.values(:,3),x_state.time, x_state.signals.values(:,3),'-.')
str1 = {'$ \hat{h} $ vs $ h $'};
title(str1, 'Interpreter','latex')
str2 = {'$ h $ (m)'};
ylabel(str2, 'Interpreter','latex')
xlabel('time (s)')
axis([0, 100, -1, 7])

subplot(3,2,2)
plot(xhat_state.time, xhat_state.signals.values(:,4),x_state.time, x_state.signals.values(:,4),'-.')
str1 = {'$ \dot{\hat{z}} $ vs $ \dot{z} $'};
title(str1, 'Interpreter','latex')
str2 = {'$ \dot{z} $ (m/s)'};
ylabel(str2, 'Interpreter','latex')
%legend('h reference', 'h')
axis([0, 100, -3, 3])

subplot(3,2,4)
plot(xhat_state.time, xhat_state.signals.values(:,5),x_state.time, x_state.signals.values(:,5),'-.')
str = {'$ \dot{\hat{\theta}} $ vs $ \dot{\theta} $'};
title(str, 'Interpreter','latex')
str2 = {'$ \dot{\theta} $ (rad/s)'};
ylabel(str2, 'Interpreter','latex')
axis([0, 100, -4, 4])

subplot(3,2,6)
plot(xhat_state.time, xhat_state.signals.values(:,6),x_state.time, x_state.signals.values(:,6),'-.')
str = {'$ \dot{\hat{h}} $ vs $ \dot{h} $'};
title(str, 'Interpreter','latex')
str2 = {'$ \dot{h} $ (m/s)'};
ylabel(str2, 'Interpreter','latex')
xlabel('time (s)')
axis([0, 100, -4, 4])

% figure(1)
% subplot(2,1,1)
% plot(dhat.time, dhat.signals.values(:,1))
% str = {'Unknown Wind Disturbance Estimate'};
% title(str, 'Interpreter','latex')
% str2 = {'Wind Force (N)'};
% ylabel(str2, 'Interpreter','latex')
% % xlabel('time (s)')
% axis([0, 200, -0.4, 0.4])
% 
% subplot(2,1,2)
% plot(dhat.time, dhat.signals.values(:,2))
% str = {'Unknown Vertical Disturbance Estimate'};
% title(str, 'Interpreter','latex')
% str2 = {'Vertical Force (N)'};
% ylabel(str2, 'Interpreter','latex')
% xlabel('time (s)')
% axis([0, 200, -1, 5])




%http://ctms.engin.umich.edu/CTMS/index.php?example=InvertedPendulum&section=ControlStateSpace