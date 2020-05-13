function W_crc = Wcheck_ball(W)  % function to keep W within unit sphere of 5D

if (norm(W)<=1)
    W_crc = W;          % Keep same W if norm <=1
else
    W_crc = W/norm(W);  % Limit in unit sphere if norm >1
end

end