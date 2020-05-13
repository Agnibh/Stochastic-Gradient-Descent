function X_crc = Xcheck_ball(X)  % function to keep X within unit sphere of 4D

X_ac = X(1:4,:);            % First 4 rows has coordinates
col = size(X_ac,2);         % No. of samples
X_crc = zeros(4,col);       % Restricted X
for a = 1:col               % Loop through the samples
    if (norm(X_ac(:,a))<=1)
        X_crc(:,a) = X_ac(:,a);     % Keep same X if norm <=1
    else
        X_crc(:,a) = X_ac(:,a)/norm(X_ac(:,a)); % Limit in unit sphere if norm >1
    end
end
X_crc = [ X_crc;ones(1,col)];   % Add rows of 1 at the end
end