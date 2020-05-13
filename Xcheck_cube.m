function X_crc = Xcheck_cube(X)  % function to keep X within unit cube of 4D

X_ac = X(1:4,:);            % First 4 rows has coordinates
col = size(X_ac,2);         % No. of samples
X_crc = zeros(4,col);       % Restricted X
for a = 1:col               % Loop through the samples
    if (abs(X_ac(1,a))<=1)
        X_crc(1,a) = X_ac(1,a);       % Keep same X if absolute value <=1
    else
        X_crc(1,a) = sign(X_ac(1,a)); % Limit in unit cube if absolute value >1
    end
    
    if (abs(X_ac(2,a))<=1)
        X_crc(2,a) = X_ac(2,a);       % Keep same X if absolute value <=1
    else
        X_crc(2,a) = sign(X_ac(2,a)); % Limit in unit cube if absolute value >1
    end
    
    if (abs(X_ac(3,a))<=1)
        X_crc(3,a) = X_ac(3,a);       % Keep same X if absolute value <=1
    else
        X_crc(3,a) = sign(X_ac(3,a)); % Limit in unit cube if absolute value >1
    end
    
    if (abs(X_ac(4,a))<=1)
        X_crc(4,a) = X_ac(4,a);       % Keep same X if absolute value <=1
    else
        X_crc(4,a) = sign(X_ac(4,a)); % Limit in unit cube if absolute value >1
    end
    
end
X_crc = [ X_crc;ones(1,col)];   % Add rows of 1 at the end
end