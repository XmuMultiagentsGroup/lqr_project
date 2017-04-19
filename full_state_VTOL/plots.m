%plots
close all

figure(1)
plot(h_desired.time, h_desired.signals.values,'-.',h_output.time, h_output.signals.values)
title('LQR Full-State Feedback (height displacement)')
xlabel('time (s)')
ylabel('height (m)')
legend('h reference', 'h')
axis([0, 200, -1, 7])

figure(2)
plot(z_desired.time, z_desired.signals.values,'-.',z_output.time, z_output.signals.values)
title('LQR Full-State Feedback (horizontal displacement)')
xlabel('time (s)')
ylabel('horizontal position, z (m)')
legend('z reference', 'h')
axis([0, 200, -1, 7])


%http://ctms.engin.umich.edu/CTMS/index.php?example=InvertedPendulum&section=ControlStateSpace