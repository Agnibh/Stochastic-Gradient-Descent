function W_crc = Wcheck_cube(W)  % function to keep W within unit sphere of 5D

if (abs(W(1,1))<=1)
    W_crc(1,1) = W(1,1);       % Keep same W if absolute value <=1
else
    W_crc(1,1) = sign(W(1,1)); % Limit in unit cube if absolute value >1
end

if (abs(W(2,1))<=1)
    W_crc(2,1) = W(2,1);       % Keep same W if absolute value <=1
else
    W_crc(2,1) = sign(W(2,1)); % Limit in unit cube if absolute value >1
end

if (abs(W(3,1))<=1)
    W_crc(3,1) = W(3,1);       % Keep same W if absolute value <=1
else
    W_crc(3,1) = sign(W(3,1)); % Limit in unit cube if absolute value >1
end

if (abs(W(4,1))<=1)
    W_crc(4,1) = W(4,1);       % Keep same W if absolute value <=1
else
    W_crc(4,1) = sign(W(4,1)); % Limit in unit cube if absolute value >1
end
    
if (abs(W(5,1))<=1)
    W_crc(5,1) = W(5,1);       % Keep same W if absolute value <=1
else
    W_crc(5,1) = sign(W(5,1)); % Limit in unit cube if absolute value >1
end

end