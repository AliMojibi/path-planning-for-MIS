function even_qs = check_qs(s, e, w, t)
    so = s;
    es = e-s;
    we = w - e;
    tw = t - w;
    
    dp = dot(so, es);
    q2 = acos(dp/(norm(so)*norm(es)));

    dp = dot(es, we);
    q4 = acos(dp/(norm(es)*norm(we)));

    dp = dot(we, tw);
    q6 = acos(dp/(norm(we)*norm(tw)));

    even_qs = [q2, q4, q6];
end