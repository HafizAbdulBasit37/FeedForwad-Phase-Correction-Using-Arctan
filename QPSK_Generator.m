%One sample per symbol
% Parameters
M = 4;                  % QPSK
numSymbols = 1000;      % number of symbols
amp = 16384;            % amplitude

% Generate random symbol indices (0..3)
symbols = randi([0 M-1], numSymbols, 1);

% Map to QPSK constellation
I = zeros(numSymbols,1);
Q = zeros(numSymbols,1);

for k = 1:numSymbols
    switch symbols(k)
        case 0
            I(k) = +amp; Q(k) = +amp;
        case 1
            I(k) = -amp; Q(k) = +amp;
        case 2
            I(k) = -amp; Q(k) = -amp;
        case 3
            I(k) = +amp; Q(k) = -amp;
    end
end

% Save to text files (one column each)a
save('I_QPSK.txt','I','-ascii');
save('Q_QPSK.txt','Q','-ascii');

% Plot constellation
figure;
plot(I, Q, 'o');
xlabel('I'); ylabel('Q'); axis equal; grid on;
title('Ideal QPSK Constellation (\pm16384)');


%Sps=16
% Load signals and here I and Q file is generated through verilog from Vivado block design simulation.These are the outputs of srrc pulse shaping filter
I = load('I'.txt');
Q = load('Q'.txt');
signal = I + 1j*Q;

% Fixed phase rotation (e.g. 45 degrees = pi/4 radians)
theta = pi/4;
rotated_signal = signal * exp(1j*theta);

% Extract rotated I and Q
I_rot = real(rotated_signal);
Q_rot = imag(rotated_signal);

% Save rotated signals
save('Isignal_rotated.txt','I_rot','-ascii');
save('Qsignal_rotated.txt','Q_rot','-ascii');

% Plot before/after
figure;
plot(I, Q, 'o'); hold on;
plot(I_rot, Q_rot, 'o');
legend('Original','Rotated');
title(['Constellation with ', num2str(theta*180/pi), '° Phase Rotation']);
xlabel('I'); ylabel('Q'); axis equal; grid on;




