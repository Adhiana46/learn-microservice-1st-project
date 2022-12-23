version := "0.0.5"

build-images:
	echo "Building images version: $(version)"
	docker build -t adhiana46/ms-node-client-react:$(version) ./client-react/
	docker build -t adhiana46/ms-node-comment-service:$(version) ./comments/
	docker build -t adhiana46/ms-node-event-bus:$(version) ./event-bus/
	docker build -t adhiana46/ms-node-moderation-service:$(version) ./moderation/
	docker build -t adhiana46/ms-node-post-service:$(version) ./posts/
	docker build -t adhiana46/ms-node-query-service:$(version) ./query/
	echo "Done building images."
push-images:
	echo "Pushing images version $(version) to docker hub"
	docker push adhiana46/ms-node-client-react:$(version)
	docker push adhiana46/ms-node-comment-service:$(version)
	docker push adhiana46/ms-node-event-bus:$(version)
	docker push adhiana46/ms-node-moderation-service:$(version)
	docker push adhiana46/ms-node-post-service:$(version)
	docker push adhiana46/ms-node-query-service:$(version)
	echo "Done pushing images."
k8s-apply:
	kubectl apply -f ./infra/k8s
k8s-delete:
	kubectl delete -f ./infra/k8s