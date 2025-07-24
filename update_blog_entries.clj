(require '[babashka.pods :as pods])
(pods/load-pod 'retrogradeorbit/bootleg "0.1.9")
(require
 '[pod.retrogradeorbit.bootleg.utils :as bootleg]
 '[pod.retrogradeorbit.hickory.select :as s])

(def BLOG_URL "https://azimut.github.io/blog/")

(defrecord Entry [date filename title])

(defn get-blog []
  (-> BLOG_URL babashka.http-client/get :body str/trim))
(defn make-table []
  (->> (bootleg/convert-to (get-blog) :hickory)
       (s/select (s/descendant (s/class "org-ul") (s/tag :li)))
       (map :content)
       (map parse-entry)
       table))

(defn parse-entry [[bold anchor]]
  (->Entry (-> bold :content first)
           (-> anchor :attrs :href)
           (-> anchor :content first)))

(defn table [entries]
  (hiccup.core/html
   [:table {:id "blogs" :align "center"}
    (for [entry entries]
      (row entry))]))

(defn row [{:keys [date filename title]}]
  [:tr
   [:td date]
   [:td [:a {:href (str BLOG_URL filename) :target "_blank"}
         title]]])
