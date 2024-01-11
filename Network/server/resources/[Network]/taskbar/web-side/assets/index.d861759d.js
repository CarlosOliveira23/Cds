(function () {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload")) return;
  for (const r of document.querySelectorAll('link[rel="modulepreload"]')) i(r);
  new MutationObserver((r) => {
    for (const s of r)
      if (s.type === "childList")
        for (const o of s.addedNodes)
          o.tagName === "LINK" && o.rel === "modulepreload" && i(o);
  }).observe(document, { childList: !0, subtree: !0 });
  function n(r) {
    const s = {};
    return (
      r.integrity && (s.integrity = r.integrity),
      r.referrerpolicy && (s.referrerPolicy = r.referrerpolicy),
      r.crossorigin === "use-credentials"
        ? (s.credentials = "include")
        : r.crossorigin === "anonymous"
        ? (s.credentials = "omit")
        : (s.credentials = "same-origin"),
      s
    );
  }
  function i(r) {
    if (r.ep) return;
    r.ep = !0;
    const s = n(r);
    fetch(r.href, s);
  }
})();
function x() {}
const ce = (e) => e;
function ae(e) {
  return e();
}
function te() {
  return Object.create(null);
}
function $(e) {
  e.forEach(ae);
}
function Y(e) {
  return typeof e == "function";
}
function $e(e, t) {
  return e != e
    ? t == t
    : e !== t || (e && typeof e == "object") || typeof e == "function";
}
function Oe(e) {
  return Object.keys(e).length === 0;
}
const de = typeof window < "u";
let Pe = de ? () => window.performance.now() : () => Date.now(),
  Z = de ? (e) => requestAnimationFrame(e) : x;
const b = new Set();
function he(e) {
  b.forEach((t) => {
    t.c(e) || (b.delete(t), t.f());
  }),
    b.size !== 0 && Z(he);
}
function Me(e) {
  let t;
  return (
    b.size === 0 && Z(he),
    {
      promise: new Promise((n) => {
        b.add((t = { c: e, f: n }));
      }),
      abort() {
        b.delete(t);
      },
    }
  );
}
function J(e, t) {
  e.appendChild(t);
}
function pe(e) {
  if (!e) return document;
  const t = e.getRootNode ? e.getRootNode() : e.ownerDocument;
  return t && t.host ? t : e.ownerDocument;
}
function ke(e) {
  const t = I("style");
  return Ne(pe(e), t), t.sheet;
}
function Ne(e, t) {
  return J(e.head || e, t), t.sheet;
}
function me(e, t, n) {
  e.insertBefore(t, n || null);
}
function z(e) {
  e.parentNode.removeChild(e);
}
function I(e) {
  return document.createElement(e);
}
function Ce(e) {
  return document.createTextNode(e);
}
function Re() {
  return Ce("");
}
function je(e, t, n, i) {
  return e.addEventListener(t, n, i), () => e.removeEventListener(t, n, i);
}
function P(e, t, n) {
  n == null
    ? e.removeAttribute(t)
    : e.getAttribute(t) !== n && e.setAttribute(t, n);
}
function Ae(e) {
  return Array.from(e.childNodes);
}
function Ie(e, t, { bubbles: n = !1, cancelable: i = !1 } = {}) {
  const r = document.createEvent("CustomEvent");
  return r.initCustomEvent(e, n, i, t), r;
}
const W = new Map();
let D = 0;
function Se(e) {
  let t = 5381,
    n = e.length;
  for (; n--; ) t = ((t << 5) - t) ^ e.charCodeAt(n);
  return t >>> 0;
}
function Te(e, t) {
  const n = { stylesheet: ke(t), rules: {} };
  return W.set(e, n), n;
}
function ne(e, t, n, i, r, s, o, f = 0) {
  const d = 16.666 / i;
  let u = `{
`;
  for (let y = 0; y <= 1; y += d) {
    const L = t + (n - t) * s(y);
    u +=
      y * 100 +
      `%{${o(L, 1 - L)}}
`;
  }
  const m =
      u +
      `100% {${o(n, 1 - n)}}
}`,
    h = `__svelte_${Se(m)}_${f}`,
    c = pe(e),
    { stylesheet: _, rules: v } = W.get(c) || Te(c, e);
  v[h] ||
    ((v[h] = !0), _.insertRule(`@keyframes ${h} ${m}`, _.cssRules.length));
  const w = e.style.animation || "";
  return (
    (e.style.animation = `${
      w ? `${w}, ` : ""
    }${h} ${i}ms linear ${r}ms 1 both`),
    (D += 1),
    h
  );
}
function Fe(e, t) {
  const n = (e.style.animation || "").split(", "),
    i = n.filter(
      t ? (s) => s.indexOf(t) < 0 : (s) => s.indexOf("__svelte") === -1
    ),
    r = n.length - i.length;
  r && ((e.style.animation = i.join(", ")), (D -= r), D || Ke());
}
function Ke() {
  Z(() => {
    D ||
      (W.forEach((e) => {
        const { ownerNode: t } = e.stylesheet;
        t && z(t);
      }),
      W.clear());
  });
}
let C;
function N(e) {
  C = e;
}
function We() {
  if (!C) throw new Error("Function called outside component initialization");
  return C;
}
function De(e) {
  We().$$.on_destroy.push(e);
}
const k = [],
  Q = [],
  S = [],
  re = [],
  ze = Promise.resolve();
let V = !1;
function Ue() {
  V || ((V = !0), ze.then(_e));
}
function R(e) {
  S.push(e);
}
const B = new Set();
let A = 0;
function _e() {
  const e = C;
  do {
    for (; A < k.length; ) {
      const t = k[A];
      A++, N(t), qe(t.$$);
    }
    for (N(null), k.length = 0, A = 0; Q.length; ) Q.pop()();
    for (let t = 0; t < S.length; t += 1) {
      const n = S[t];
      B.has(n) || (B.add(n), n());
    }
    S.length = 0;
  } while (k.length);
  for (; re.length; ) re.pop()();
  (V = !1), B.clear(), N(e);
}
function qe(e) {
  if (e.fragment !== null) {
    e.update(), $(e.before_update);
    const t = e.dirty;
    (e.dirty = [-1]),
      e.fragment && e.fragment.p(e.ctx, t),
      e.after_update.forEach(R);
  }
}
let M;
function Be() {
  return (
    M ||
      ((M = Promise.resolve()),
      M.then(() => {
        M = null;
      })),
    M
  );
}
function G(e, t, n) {
  e.dispatchEvent(Ie(`${t ? "intro" : "outro"}${n}`));
}
const T = new Set();
let g;
function Ge() {
  g = { r: 0, c: [], p: g };
}
function He() {
  g.r || $(g.c), (g = g.p);
}
function F(e, t) {
  e && e.i && (T.delete(e), e.i(t));
}
function ie(e, t, n, i) {
  if (e && e.o) {
    if (T.has(e)) return;
    T.add(e),
      g.c.push(() => {
        T.delete(e), i && (n && e.d(1), i());
      }),
      e.o(t);
  } else i && i();
}
const Je = { duration: 0 };
function oe(e, t, n, i) {
  let r = t(e, n),
    s = i ? 0 : 1,
    o = null,
    f = null,
    d = null;
  function u() {
    d && Fe(e, d);
  }
  function m(c, _) {
    const v = c.b - s;
    return (
      (_ *= Math.abs(v)),
      {
        a: s,
        b: c.b,
        d: v,
        duration: _,
        start: c.start,
        end: c.start + _,
        group: c.group,
      }
    );
  }
  function h(c) {
    const {
        delay: _ = 0,
        duration: v = 300,
        easing: w = ce,
        tick: y = x,
        css: L,
      } = r || Je,
      O = { start: Pe() + _, b: c };
    c || ((O.group = g), (g.r += 1)),
      o || f
        ? (f = O)
        : (L && (u(), (d = ne(e, s, c, v, _, w, L))),
          c && y(0, 1),
          (o = m(O, v)),
          R(() => G(e, c, "start")),
          Me((p) => {
            if (
              (f &&
                p > f.start &&
                ((o = m(f, v)),
                (f = null),
                G(e, o.b, "start"),
                L && (u(), (d = ne(e, s, o.b, o.duration, 0, w, r.css)))),
              o)
            ) {
              if (p >= o.end)
                y((s = o.b), 1 - s),
                  G(e, o.b, "end"),
                  f || (o.b ? u() : --o.group.r || $(o.group.c)),
                  (o = null);
              else if (p >= o.start) {
                const a = p - o.start;
                (s = o.a + o.d * w(a / o.duration)), y(s, 1 - s);
              }
            }
            return !!(o || f);
          }));
  }
  return {
    run(c) {
      Y(r)
        ? Be().then(() => {
            (r = r()), h(c);
          })
        : h(c);
    },
    end() {
      u(), (o = f = null);
    },
  };
}
function Qe(e, t, n, i) {
  const { fragment: r, after_update: s } = e.$$;
  r && r.m(t, n),
    i ||
      R(() => {
        const o = e.$$.on_mount.map(ae).filter(Y);
        e.$$.on_destroy ? e.$$.on_destroy.push(...o) : $(o),
          (e.$$.on_mount = []);
      }),
    s.forEach(R);
}
function Ve(e, t) {
  const n = e.$$;
  n.fragment !== null &&
    ($(n.on_destroy),
    n.fragment && n.fragment.d(t),
    (n.on_destroy = n.fragment = null),
    (n.ctx = []));
}
function Xe(e, t) {
  e.$$.dirty[0] === -1 && (k.push(e), Ue(), e.$$.dirty.fill(0)),
    (e.$$.dirty[(t / 31) | 0] |= 1 << t % 31);
}
function Ye(e, t, n, i, r, s, o, f = [-1]) {
  const d = C;
  N(e);
  const u = (e.$$ = {
    fragment: null,
    ctx: [],
    props: s,
    update: x,
    not_equal: r,
    bound: te(),
    on_mount: [],
    on_destroy: [],
    on_disconnect: [],
    before_update: [],
    after_update: [],
    context: new Map(t.context || (d ? d.$$.context : [])),
    callbacks: te(),
    dirty: f,
    skip_bound: !1,
    root: t.target || d.$$.root,
  });
  o && o(u.root);
  let m = !1;
  if (
    ((u.ctx = n
      ? n(e, t.props || {}, (h, c, ..._) => {
          const v = _.length ? _[0] : c;
          return (
            u.ctx &&
              r(u.ctx[h], (u.ctx[h] = v)) &&
              (!u.skip_bound && u.bound[h] && u.bound[h](v), m && Xe(e, h)),
            c
          );
        })
      : []),
    u.update(),
    (m = !0),
    $(u.before_update),
    (u.fragment = i ? i(u.ctx) : !1),
    t.target)
  ) {
    if (t.hydrate) {
      const h = Ae(t.target);
      u.fragment && u.fragment.l(h), h.forEach(z);
    } else u.fragment && u.fragment.c();
    t.intro && F(e.$$.fragment),
      Qe(e, t.target, t.anchor, t.customElement),
      _e();
  }
  N(d);
}
class Ze {
  $destroy() {
    Ve(this, 1), (this.$destroy = x);
  }
  $on(t, n) {
    if (!Y(n)) return x;
    const i = this.$$.callbacks[t] || (this.$$.callbacks[t] = []);
    return (
      i.push(n),
      () => {
        const r = i.indexOf(n);
        r !== -1 && i.splice(r, 1);
      }
    );
  }
  $set(t) {
    this.$$set &&
      !Oe(t) &&
      ((this.$$.skip_bound = !0), this.$$set(t), (this.$$.skip_bound = !1));
  }
}
function se(e, { delay: t = 0, duration: n = 400, easing: i = ce } = {}) {
  const r = +getComputedStyle(e).opacity;
  return { delay: t, duration: n, easing: i, css: (s) => `opacity: ${s * r}` };
}
var ee = { exports: {} },
  E = typeof Reflect == "object" ? Reflect : null,
  fe =
    E && typeof E.apply == "function"
      ? E.apply
      : function (t, n, i) {
          return Function.prototype.apply.call(t, n, i);
        },
  K;
E && typeof E.ownKeys == "function"
  ? (K = E.ownKeys)
  : Object.getOwnPropertySymbols
  ? (K = function (t) {
      return Object.getOwnPropertyNames(t).concat(
        Object.getOwnPropertySymbols(t)
      );
    })
  : (K = function (t) {
      return Object.getOwnPropertyNames(t);
    });
function et(e) {
  console && console.warn && console.warn(e);
}
var ve =
  Number.isNaN ||
  function (t) {
    return t !== t;
  };
function l() {
  l.init.call(this);
}
ee.exports = l;
ee.exports.once = it;
l.EventEmitter = l;
l.prototype._events = void 0;
l.prototype._eventsCount = 0;
l.prototype._maxListeners = void 0;
var ue = 10;
function U(e) {
  if (typeof e != "function")
    throw new TypeError(
      'The "listener" argument must be of type Function. Received type ' +
        typeof e
    );
}
Object.defineProperty(l, "defaultMaxListeners", {
  enumerable: !0,
  get: function () {
    return ue;
  },
  set: function (e) {
    if (typeof e != "number" || e < 0 || ve(e))
      throw new RangeError(
        'The value of "defaultMaxListeners" is out of range. It must be a non-negative number. Received ' +
          e +
          "."
      );
    ue = e;
  },
});
l.init = function () {
  (this._events === void 0 ||
    this._events === Object.getPrototypeOf(this)._events) &&
    ((this._events = Object.create(null)), (this._eventsCount = 0)),
    (this._maxListeners = this._maxListeners || void 0);
};
l.prototype.setMaxListeners = function (t) {
  if (typeof t != "number" || t < 0 || ve(t))
    throw new RangeError(
      'The value of "n" is out of range. It must be a non-negative number. Received ' +
        t +
        "."
    );
  return (this._maxListeners = t), this;
};
function ye(e) {
  return e._maxListeners === void 0 ? l.defaultMaxListeners : e._maxListeners;
}
l.prototype.getMaxListeners = function () {
  return ye(this);
};
l.prototype.emit = function (t) {
  for (var n = [], i = 1; i < arguments.length; i++) n.push(arguments[i]);
  var r = t === "error",
    s = this._events;
  if (s !== void 0) r = r && s.error === void 0;
  else if (!r) return !1;
  if (r) {
    var o;
    if ((n.length > 0 && (o = n[0]), o instanceof Error)) throw o;
    var f = new Error("Unhandled error." + (o ? " (" + o.message + ")" : ""));
    throw ((f.context = o), f);
  }
  var d = s[t];
  if (d === void 0) return !1;
  if (typeof d == "function") fe(d, this, n);
  else
    for (var u = d.length, m = Ee(d, u), i = 0; i < u; ++i) fe(m[i], this, n);
  return !0;
};
function ge(e, t, n, i) {
  var r, s, o;
  if (
    (U(n),
    (s = e._events),
    s === void 0
      ? ((s = e._events = Object.create(null)), (e._eventsCount = 0))
      : (s.newListener !== void 0 &&
          (e.emit("newListener", t, n.listener ? n.listener : n),
          (s = e._events)),
        (o = s[t])),
    o === void 0)
  )
    (o = s[t] = n), ++e._eventsCount;
  else if (
    (typeof o == "function"
      ? (o = s[t] = i ? [n, o] : [o, n])
      : i
      ? o.unshift(n)
      : o.push(n),
    (r = ye(e)),
    r > 0 && o.length > r && !o.warned)
  ) {
    o.warned = !0;
    var f = new Error(
      "Possible EventEmitter memory leak detected. " +
        o.length +
        " " +
        String(t) +
        " listeners added. Use emitter.setMaxListeners() to increase limit"
    );
    (f.name = "MaxListenersExceededWarning"),
      (f.emitter = e),
      (f.type = t),
      (f.count = o.length),
      et(f);
  }
  return e;
}
l.prototype.addListener = function (t, n) {
  return ge(this, t, n, !1);
};
l.prototype.on = l.prototype.addListener;
l.prototype.prependListener = function (t, n) {
  return ge(this, t, n, !0);
};
function tt() {
  if (!this.fired)
    return (
      this.target.removeListener(this.type, this.wrapFn),
      (this.fired = !0),
      arguments.length === 0
        ? this.listener.call(this.target)
        : this.listener.apply(this.target, arguments)
    );
}
function we(e, t, n) {
  var i = { fired: !1, wrapFn: void 0, target: e, type: t, listener: n },
    r = tt.bind(i);
  return (r.listener = n), (i.wrapFn = r), r;
}
l.prototype.once = function (t, n) {
  return U(n), this.on(t, we(this, t, n)), this;
};
l.prototype.prependOnceListener = function (t, n) {
  return U(n), this.prependListener(t, we(this, t, n)), this;
};
l.prototype.removeListener = function (t, n) {
  var i, r, s, o, f;
  if ((U(n), (r = this._events), r === void 0)) return this;
  if (((i = r[t]), i === void 0)) return this;
  if (i === n || i.listener === n)
    --this._eventsCount === 0
      ? (this._events = Object.create(null))
      : (delete r[t],
        r.removeListener && this.emit("removeListener", t, i.listener || n));
  else if (typeof i != "function") {
    for (s = -1, o = i.length - 1; o >= 0; o--)
      if (i[o] === n || i[o].listener === n) {
        (f = i[o].listener), (s = o);
        break;
      }
    if (s < 0) return this;
    s === 0 ? i.shift() : nt(i, s),
      i.length === 1 && (r[t] = i[0]),
      r.removeListener !== void 0 && this.emit("removeListener", t, f || n);
  }
  return this;
};
l.prototype.off = l.prototype.removeListener;
l.prototype.removeAllListeners = function (t) {
  var n, i, r;
  if (((i = this._events), i === void 0)) return this;
  if (i.removeListener === void 0)
    return (
      arguments.length === 0
        ? ((this._events = Object.create(null)), (this._eventsCount = 0))
        : i[t] !== void 0 &&
          (--this._eventsCount === 0
            ? (this._events = Object.create(null))
            : delete i[t]),
      this
    );
  if (arguments.length === 0) {
    var s = Object.keys(i),
      o;
    for (r = 0; r < s.length; ++r)
      (o = s[r]), o !== "removeListener" && this.removeAllListeners(o);
    return (
      this.removeAllListeners("removeListener"),
      (this._events = Object.create(null)),
      (this._eventsCount = 0),
      this
    );
  }
  if (((n = i[t]), typeof n == "function")) this.removeListener(t, n);
  else if (n !== void 0)
    for (r = n.length - 1; r >= 0; r--) this.removeListener(t, n[r]);
  return this;
};
function Le(e, t, n) {
  var i = e._events;
  if (i === void 0) return [];
  var r = i[t];
  return r === void 0
    ? []
    : typeof r == "function"
    ? n
      ? [r.listener || r]
      : [r]
    : n
    ? rt(r)
    : Ee(r, r.length);
}
l.prototype.listeners = function (t) {
  return Le(this, t, !0);
};
l.prototype.rawListeners = function (t) {
  return Le(this, t, !1);
};
l.listenerCount = function (e, t) {
  return typeof e.listenerCount == "function"
    ? e.listenerCount(t)
    : be.call(e, t);
};
l.prototype.listenerCount = be;
function be(e) {
  var t = this._events;
  if (t !== void 0) {
    var n = t[e];
    if (typeof n == "function") return 1;
    if (n !== void 0) return n.length;
  }
  return 0;
}
l.prototype.eventNames = function () {
  return this._eventsCount > 0 ? K(this._events) : [];
};
function Ee(e, t) {
  for (var n = new Array(t), i = 0; i < t; ++i) n[i] = e[i];
  return n;
}
function nt(e, t) {
  for (; t + 1 < e.length; t++) e[t] = e[t + 1];
  e.pop();
}
function rt(e) {
  for (var t = new Array(e.length), n = 0; n < t.length; ++n)
    t[n] = e[n].listener || e[n];
  return t;
}
function it(e, t) {
  return new Promise(function (n, i) {
    function r(o) {
      e.removeListener(t, s), i(o);
    }
    function s() {
      typeof e.removeListener == "function" && e.removeListener("error", r),
        n([].slice.call(arguments));
    }
    xe(e, t, s, { once: !0 }), t !== "error" && ot(e, r, { once: !0 });
  });
}
function ot(e, t, n) {
  typeof e.on == "function" && xe(e, "error", t, n);
}
function xe(e, t, n, i) {
  if (typeof e.on == "function") i.once ? e.once(t, n) : e.on(t, n);
  else if (typeof e.addEventListener == "function")
    e.addEventListener(t, function r(s) {
      i.once && e.removeEventListener(t, r), n(s);
    });
  else
    throw new TypeError(
      'The "emitter" argument must be of type EventEmitter. Received type ' +
        typeof e
    );
}
const X = new ee.exports.EventEmitter();
window.addEventListener("message", (e) => X.emit(e.data.name, e.data.payload));
function st(e, t) {
  X.on(e, t), De(() => X.removeListener(e, t));
}
async function ft(e, t) {
  var o;
  const n =
      (o = window.GetParentResourceName) == null ? void 0 : o.call(window),
    i = new URL(e, `http://${n}/`),
    r = { method: "POST", body: JSON.stringify(t) };
  return await (await fetch(i, r)).json();
}
function le(e) {
  let t, n, i, r, s;
  return {
    c() {
      (t = I("div")),
        (n = I("div")),
        (i = I("canvas")),
        P(i, "width", "300"),
        P(i, "height", "300"),
        P(i, "class", "svelte-3fx74w"),
        P(n, "class", "absolute bottom-40"),
        P(
          t,
          "class",
          "fixed grid inset-0 place-items-center font-poppins text-white " +
            (location.port === "5173" && "bg-black/50")
        );
    },
    m(o, f) {
      me(o, t, f), J(t, n), J(n, i), e[3](i), (s = !0);
    },
    p: x,
    i(o) {
      s ||
        (R(() => {
          r || (r = oe(t, se, {}, !0)), r.run(1);
        }),
        (s = !0));
    },
    o(o) {
      r || (r = oe(t, se, {}, !1)), r.run(0), (s = !1);
    },
    d(o) {
      o && z(t), e[3](null), o && r && r.end();
    },
  };
}
function ut(e) {
  let t,
    n,
    i,
    r,
    s = e[0] && le(e);
  return {
    c() {
      s && s.c(), (t = Re());
    },
    m(o, f) {
      s && s.m(o, f),
        me(o, t, f),
        (n = !0),
        i || ((r = je(window, "keydown", e[2])), (i = !0));
    },
    p(o, [f]) {
      o[0]
        ? s
          ? (s.p(o, f), f & 1 && F(s, 1))
          : ((s = le(o)), s.c(), F(s, 1), s.m(t.parentNode, t))
        : s &&
          (Ge(),
          ie(s, 1, 1, () => {
            s = null;
          }),
          He());
    },
    i(o) {
      n || (F(s), (n = !0));
    },
    o(o) {
      ie(s), (n = !1);
    },
    d(o) {
      s && s.d(o), o && z(t), (i = !1), r();
    },
  };
}
let lt = "#fff",
  ct = "#ffffff",
  at = "rgba(15, 15, 15, 0.75)",
  dt = "#41a491";
function H(e, t) {
  return (
    (e = Math.ceil(e)),
    (t = Math.floor(t)),
    Math.floor(Math.random() * (t - e + 1) + e)
  );
}
function ht(e, t, n) {
  let i = location.port === "5173" || !1,
    r,
    s = 0,
    o = 0,
    f = 0,
    d,
    u,
    m,
    h,
    c = "#00ff00";
  st("Open", (p) => {
    n(0, (i = !0)), w(p / 1e3 + 3);
  });
  function _(p) {
    const a = r.getContext("2d");
    a.clearRect(0, 0, r.width, r.height),
      a.beginPath(),
      (a.strokeStyle = at),
      (a.lineWidth = 20),
      a.arc(r.width / 2, r.height / 2, 100, 0, Math.PI * 2, !1),
      a.stroke(),
      a.beginPath(),
      (a.strokeStyle = p ? c : dt),
      (a.lineWidth = 20),
      a.arc(
        r.width / 2,
        r.height / 2,
        100,
        u - (90 * Math.PI) / 180,
        m - (90 * Math.PI) / 180,
        !1
      ),
      a.stroke();
    let j = (s * Math.PI) / 180;
    a.beginPath(),
      (a.strokeStyle = lt),
      (a.lineWidth = 40),
      a.arc(
        r.width / 2,
        r.height / 2,
        90,
        j - 0.1 - (90 * Math.PI) / 180,
        j - (90 * Math.PI) / 180,
        !1
      ),
      a.stroke(),
      (a.fillStyle = ct),
      (a.font = "100px Poppins, sans-serif");
    let q = a.measureText(d).width;
    a.fillText(d, r.width / 2 - q / 2, r.height / 2 + 35);
  }
  function v() {
    if (s >= o) {
      y("failure");
      return;
    }
    (s += 2), _();
  }
  function w(p) {
    typeof h !== void 0 && clearInterval(h),
      (u = H(15, 30) / 10),
      (m = H(6, 8) / 10),
      (m = u + m),
      (s = 0),
      (o = 360),
      (d = "" + H(1, 4)),
      (f = p),
      (h = setInterval(v, f)),
      setTimeout(() => {
        n(0, (i = !0));
      }, 100);
  }
  function y(p) {
    clearInterval(h), ft(p), n(0, (i = !1));
  }
  function L(p) {
    if (["1", "2", "3", "4"].includes(p.key)) {
      if (((c = "#ff0000"), p.key === d)) {
        let j = (180 / Math.PI) * u,
          q = (180 / Math.PI) * m;
        s < j || s > q ? y("failure") : ((c = "#00ff00"), y("success"));
      } else y("failure");
      _(!0);
    }
  }
  function O(p) {
    Q[p ? "unshift" : "push"](() => {
      (r = p), n(1, r);
    });
  }
  return [i, r, L, O];
}
class pt extends Ze {
  constructor(t) {
    super(), Ye(this, t, ht, ut, $e, {});
  }
}
new pt({ target: document.getElementById("app") });
